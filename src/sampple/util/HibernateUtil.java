package sampple.util;

import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

public class HibernateUtil {
	
	private HibernateUtil() {
		throw new IllegalStateException("Utility class");
	}

	private static final SessionFactory factory = createSessionFactory();

	private static SessionFactory createSessionFactory() {
		StandardServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder().configure().build();
		return new MetadataSources(serviceRegistry).buildMetadata().buildSessionFactory();
	}

	public static SessionFactory getSessionFactory() {
		return factory;
	}

	public static void closeSessionFactory() {
		if (factory != null) {
			factory.close();
		}
	}

}
