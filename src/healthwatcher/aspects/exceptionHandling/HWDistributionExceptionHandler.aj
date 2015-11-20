package healthwatcher.aspects.exceptionHandling;

import healthwatcher.view.servlets.HWServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.rmi.RemoteException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lib.exceptions.CommunicationException;

/**
 * This aspect handles transaction exceptions in the servlets
 */
public aspect HWDistributionExceptionHandler {

	// Makes soft all IO exceptions raised in this aspect
	declare soft : IOException : within(HWDistributionExceptionHandler+);
	
	void around(HttpServletResponse response) : 
		execution(* HWServlet+.doGet(HttpServletRequest, HttpServletResponse)) &&
		args(response) {
		
		PrintWriter out = response.getWriter();
		try {
			
			proceed(response);
			
        } catch (CommunicationException e) {
        	out.println("<P> " + e.getMessage() + " </P>");
		} catch (RemoteException e) {
        	out.println(lib.util.HTMLCode.errorPage("Comunication error, please try again later."));
		}
	}
}
