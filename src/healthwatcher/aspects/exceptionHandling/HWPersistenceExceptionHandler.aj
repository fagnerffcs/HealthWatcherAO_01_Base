package healthwatcher.aspects.exceptionHandling;

import healthwatcher.view.servlets.HWServlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lib.exceptions.RepositoryException;

/**
 * This aspect handles repository exceptions in the servlets
 */
public aspect HWPersistenceExceptionHandler {

	// Makes soft all IO exceptions raised in this aspect
	declare soft : IOException : within(HWPersistenceExceptionHandler+);
	
	void around(HttpServletResponse response) : 
		execution(* HWServlet+.doGet(HttpServletRequest, HttpServletResponse)) &&
		args(.., response) {
		
		try {
			
			proceed(response);
			
        } catch (RepositoryException e) {
        	PrintWriter out = response.getWriter();
            out.println("</select></p></center></div>");
            out.println("<P> " + e.getMessage() + " </P>");
		}
	}
}
