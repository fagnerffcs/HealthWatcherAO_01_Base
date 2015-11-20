package healthwatcher.aspects.distribution;

import healthwatcher.view.IFacade;
import healthwatcher.view.servlets.HWServlet;

import java.rmi.Remote;
import java.rmi.RemoteException;

import lib.distribution.rmi.IteratorRMISourceAdapter;
import lib.distribution.rmi.IteratorRMITargetAdapter;
import lib.distribution.rmi.MethodExecutor;
import lib.exceptions.CommunicationException;
import lib.util.IteratorDsk;
import lib.util.LocalIterator;

/**
 * TODO - describe this file
 * 
 */
public aspect HWClientDistribution {
	
	// Makes soft the communication exceptions in the clients
	declare soft : CommunicationException : call(* IteratorDsk+.*(..));
	
	// Makes soft remote exceptions raised in this aspect
	declare soft : RemoteException : within(HWClientDistribution+);
	
	/**
	 * Keeps the remote instance
	 */
	protected IRemoteFacade facade = null;
    
    /**
     * Redirects the facade methods call to the distributed instance methods using reflection
     */
	Object around() : call(* IFacade+.*(..)) && ! call(static * *.*(..)) && this(HWServlet+) {
	    Object obj = MethodExecutor.invoke(
	    	getRemoteFacade(), thisJoinPoint.getSignature().getName(), thisJoinPoint.getArgs());
	    if (obj instanceof LocalIterator) {
			IteratorRMITargetAdapter iteratorTA = new IteratorRMITargetAdapter((LocalIterator) obj, 3);
			return new IteratorRMISourceAdapter(iteratorTA, (LocalIterator) obj, 3);
	    }
	    return obj;
    }
    
    /**
     * Retrieves the remote instance, creating if needed
     */
	private synchronized Remote getRemoteFacade() {        
		if (facade == null) {
			try {
	            System.out.println("About to lookup...");
	            facade = (IRemoteFacade) java.rmi.Naming.lookup("//" + healthwatcher.Constants.SERVER_NAME + "/" + healthwatcher.Constants.SYSTEM_NAME);
	            System.out.println("Remote DisqueSaude found");
	        } catch (java.rmi.RemoteException rmiEx) {
	            rmiInitExceptionHandling(rmiEx);
	        } catch (java.rmi.NotBoundException rmiEx) {
	            rmiInitExceptionHandling(rmiEx);
	        } catch (java.net.MalformedURLException rmiEx) {
	            rmiInitExceptionHandling(rmiEx);
	        }
		}
		return facade;
    }
	
    protected void rmiInitExceptionHandling(Throwable exception) {
    	String error =  "<p>****************************************************<br>" +
                 "Error during servlet initialization!<br>" +
                 "The exception message is:<br><dd>" + exception.getMessage() +
                 "<p>You may have to restart the servlet container.<br>" +
                 "*******************************************************";
        System.out.println(error);
    }
}
