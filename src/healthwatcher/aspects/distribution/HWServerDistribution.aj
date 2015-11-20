package healthwatcher.aspects.distribution;

import healthwatcher.business.HealthWatcherFacade;

import java.rmi.server.UnicastRemoteObject;

/**
 * This is the server part for distribution. The following tasks are done:
 * 
 * 1) makes the facade implement the remote interface
 * 2) makes model classes serializable (actually this is also needed in the client)
 * 3) creates a main method in the facade, to start the server
 * 4) publishes the facade as an rmi server when starting
 */
public aspect HWServerDistribution {

	/**
	 * Forces the facade to implement a remote interface, needed for RMI
	 */
	declare parents: HealthWatcherFacade implements IRemoteFacade;

	/**
	 * Declare the model classes serializable
	 */
	declare parents : healthwatcher.model..* implements java.io.Serializable;

	/**
	 * Creates main method to be able to start the server
	 */
	public static void HealthWatcherFacade.main(String[] args) {
		try {
			HealthWatcherFacade.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Publishes the server when it starts
	 */
	void around(): execution(static void HealthWatcherFacade.main(String[])) {
		try {
			System.out.println("Creating RMI server...");
			UnicastRemoteObject.exportObject(HealthWatcherFacade.getInstance());
			System.out.println("Object exported");
			System.out.println(healthwatcher.Constants.SYSTEM_NAME);
			java.rmi.Naming.rebind("//" + healthwatcher.Constants.SERVER_NAME + "/"
					+ healthwatcher.Constants.SYSTEM_NAME, HealthWatcherFacade.getInstance());
			System.out.println("Server created and ready.");
		} catch (java.rmi.RemoteException rmiEx) {
			rmiFacadeExceptionHandling(rmiEx);
		} catch (java.net.MalformedURLException rmiEx) {
			rmiFacadeExceptionHandling(rmiEx);
		}
	}

	private void rmiFacadeExceptionHandling(Throwable exception) {
		System.out.println("**************************************************");
		System.out.println("* Error during server initialization!            *");
		System.out.println("* The exception message is:                      *");
		System.out.println("      " + exception.getMessage());
		System.out.println("* You may have to restart the server or registry.*");
		System.out.println("**************************************************");
		exception.printStackTrace();
	}
}
