package healthwatcher.aspects.exceptionHandling;

import healthwatcher.view.servlets.HWServlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lib.exceptions.TransactionException;

/**
 * This aspect handles transaction exceptions in the servlets
 */
public aspect HWTransactionExceptionHandler {

	// Makes soft all IO exceptions raised in this aspect
	declare soft : IOException : within(HWTransactionExceptionHandler+);
	
	void around(HttpServletResponse response) : 
		execution(* HWServlet+.doGet(HttpServletRequest, HttpServletResponse)) &&
		args(.., response) {
		
		try {
			
			proceed(response);
			
        } catch (TransactionException e) {
        	PrintWriter out = response.getWriter();
            out.println("</select></p></center></div>");
            out.println("<P> " + e.getMessage() + " </P>");
		}
	}
}
