
package healthwatcher.view.servlets;


import healthwatcher.Constants;
import healthwatcher.model.complaint.DiseaseType;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lib.exceptions.ObjectNotFoundException;
import lib.util.HTMLCode;
import lib.util.IteratorDsk;




public class ServletGetDataForSearchByDiseaseType extends HWServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out;

        response.setContentType("text/html");

        out = response.getWriter();

        out.println(HTMLCode.open("Queries - Disease information"));
        out.println("<body><h1>Queries:<br>Querie about diseases</h1>");
        out.println("<p>Choose a disease: </p>");
        out.println("<form method=\"POST\" action=\"http://"+Constants.SERVLET_SERVER_PATH+"ServletSearchDiseaseData\">");

        try {
            out.println("<div align=\"center\"><center><p><select name=\"codTipoDoenca\" size=\"1\">");
            IteratorDsk repTP = facade.getDiseaseTypeList();
            
            if (repTP==null||!repTP.hasNext()) {
                out.println("</select></p></center></div>");
                out.println("<p><font color=\"red\"><b> There isn't diseases registered.</b></font></p>");
            } else {
                DiseaseType tp;
                do {
                    tp = (DiseaseType) repTP.next();

                    out.println("<option value=\""+ tp.getCode() + "\"> " + tp.getName()+ " </OPTION>");
                } while (repTP.hasNext());
                repTP.close();
                
                out.println("</select></p></center></div>");
                out.println("<div align=\"center\"><center><p><input type=\"submit\" value=\"Consultar\" name=\"B1\"></p></center></div></form>");
            }
            out.println(HTMLCode.closeQueries());
        } catch (ObjectNotFoundException e) {
        	out.println(HTMLCode.errorPageQueries("There isn't registered diseases"));
        }finally {
            out.close();
        }
    }
}