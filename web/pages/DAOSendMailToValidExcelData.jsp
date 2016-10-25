<%-- 
    Document   : DAOSendMailToValidExcelData
    Created on : 27 Jun, 2015, 11:13:17 AM
    Author     : asl
--%>

<%@page import="org.project.utilities.SendPrivateLink"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.utilities.ExcelRead"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.bean.Person"%>
<%
    try {
        String upid = request.getParameter("fileid");
        Person person;
        int mailcount=0,mailSendtotal=0;
        SendPrivateLink spl=new SendPrivateLink();
        ArrayList<Person> personsdata = new ArrayList<Person>();
        ExcelRead exr = new ExcelRead();
        String context=getServletContext().getRealPath("/"); 
        personsdata = exr.getAllValidData(Integer.parseInt(upid));
        for (int i = 0; i < personsdata.size(); i++) {
            person = (org.project.bean.Person) personsdata.get(i);
            mailcount=spl.sendPrivateLinkToUser(person.getPer_user_id(), context,person.getEmail());
            if(mailcount > 0){
              mailSendtotal++;
            }
            //send mail utility called here
        }
        Gson gson = new Gson();
        gson.toJson(mailSendtotal);
        out.print(gson.toJson(mailSendtotal));
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
