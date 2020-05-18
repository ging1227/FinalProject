package sampple.config;

import java.util.Properties;

import javax.naming.NamingException;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.quartz.JobDetail;
import org.quartz.Trigger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.jndi.JndiObjectFactoryBean;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.scheduling.quartz.MethodInvokingJobDetailFactoryBean;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.scheduling.quartz.SimpleTriggerFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import sampple.util.AdMailUtils;
import sampple.util.PickUpMailUtils;

@Configuration
@EnableTransactionManagement
public class RootAppConfig {

	private static final Logger logger = Logger.getLogger(RootAppConfig.class);

	Environment env;

	@Autowired
	public void setEnv(Environment env) {
		this.env = env;
	}

	/* Session Factory Setting */
	@Bean(destroyMethod = "destroy")
	public LocalSessionFactoryBean sessionFactory() throws NamingException {
		LocalSessionFactoryBean factory = new LocalSessionFactoryBean();
		factory.setDataSource(dataSource());
		factory.setPackagesToScan("sampple.model");
		factory.setHibernateProperties(additionalProperties());
		return factory;
	}

	/* JNDI Setting */
	@Bean
	public DataSource dataSource() throws NamingException {
		JndiObjectFactoryBean jndiBean = new JndiObjectFactoryBean();
		jndiBean.setJndiName("java:comp/env/FinalProject");
		jndiBean.setProxyInterface(DataSource.class);
		jndiBean.setLookupOnStartup(false);
		jndiBean.afterPropertiesSet();
		DataSource ds = (DataSource) jndiBean.getObject();
		logger.info("ds = " + ds);

		return ds;
	}

	/* Hibernate Setting */
	private Properties additionalProperties() {
		Properties properties = new Properties();
		properties.put("hibernate.dialect", org.hibernate.dialect.SQLServerDialect.class);
		properties.put("hibernate.show_sql", Boolean.TRUE);
		properties.put("hibernate.format_sql", Boolean.TRUE);
		properties.put("hibernate.current_session_context_class", "thread");
		return properties;
	}

	@Autowired
	@Bean(name = "transactionManager")
	public HibernateTransactionManager transactionManager(SessionFactory sessionFactory) {
		HibernateTransactionManager txManager = new HibernateTransactionManager();
		txManager.setSessionFactory(sessionFactory);
		return txManager;
	}

	// 使用Quartz來設定排程
	@Autowired
	@Bean(name = "targetClass")
	public AdMailUtils targetClass(SessionFactory sessionFactory) {
		return new AdMailUtils(sessionFactory);
	}

	// 定時器具體作業
	@Autowired
	@Bean(name = "jobDetail")
	public MethodInvokingJobDetailFactoryBean jobDetail(@Qualifier(value = "targetClass") AdMailUtils ad) {
		MethodInvokingJobDetailFactoryBean methodInvoking = new MethodInvokingJobDetailFactoryBean();
		methodInvoking.setTargetObject(ad);
		methodInvoking.setTargetMethod("executeMethod");
		return methodInvoking;
	}

	// 觸發點(方法一)
	@Autowired
	@Bean(name = "cronTrigger")
	public SimpleTriggerFactoryBean cronTrigger(@Qualifier(value = "jobDetail") JobDetail jobDetail) {
		SimpleTriggerFactoryBean simpleTrigger = new SimpleTriggerFactoryBean();
		simpleTrigger.setJobDetail(jobDetail);
		simpleTrigger.setRepeatInterval(120000);
		simpleTrigger.setStartDelay(0);
		simpleTrigger.setRepeatCount(8);
		return simpleTrigger;
	}

	// 排程器工廠
	@Autowired
	@Bean
	public SchedulerFactoryBean schedulerFactoryBean(@Qualifier(value = "cronTrigger") Trigger[] cronTrigger) {
		SchedulerFactoryBean scheduler = new SchedulerFactoryBean();
		scheduler.setTriggers(cronTrigger);
		return scheduler;
	}

	// 使用Quartz來設定排程:取貨通知信用
	@Autowired
	@Bean(name = "targetClass2")
	public PickUpMailUtils targetClass2(SessionFactory sessionFactory) {
		return new PickUpMailUtils(sessionFactory);
	}

	// 定時器具體作業:取貨通知信用
	@Autowired
	@Bean(name = "jobsDetail")
	public MethodInvokingJobDetailFactoryBean jobsDetail(@Qualifier(value = "targetClass2") PickUpMailUtils pickup) {
		MethodInvokingJobDetailFactoryBean methodInvoking2 = new MethodInvokingJobDetailFactoryBean();
		methodInvoking2.setTargetObject(pickup);
		methodInvoking2.setTargetMethod("executeMethod");
		return methodInvoking2;
	}

	// 觸發點(方法一:取貨通知信用)
	@Autowired
	@Bean(name = "pickupTrigger")
	public SimpleTriggerFactoryBean pickupTrigger(@Qualifier(value = "jobsDetail") JobDetail jobsDetail) {
		SimpleTriggerFactoryBean simpleTrigger2 = new SimpleTriggerFactoryBean();
		simpleTrigger2.setJobDetail(jobsDetail);
		simpleTrigger2.setRepeatInterval(60000);
		simpleTrigger2.setStartDelay(0);
		simpleTrigger2.setRepeatCount(1);
		return simpleTrigger2;
	}

	// 排程器工廠:取貨通知信用
	@Autowired
	@Bean
	public SchedulerFactoryBean schedulerFactoryBean2(@Qualifier(value = "pickupTrigger") Trigger[] pickupTrigger) {
		SchedulerFactoryBean scheduler2 = new SchedulerFactoryBean();
		// 排程:取貨通知信
		scheduler2.setStartupDelay(1);
		scheduler2.setTriggers(pickupTrigger);
		return scheduler2;
	}
}
