<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<%
    UtilityProcess process = new UtilityProcess();
    String[] splited = request.getParameter("data").trim().split(" ");
    String workshopid = (splited[0]);
    String categorycode = (splited[1]);
    String state = (splited[2]);
    String res_coid=(splited[3]);
    String stateName="";
    if(!state.equals("all")){
        stateName=process.getStateName(state);
    }else if(state.equals("all")){
        stateName ="all";
    }
    String context=getServletContext().getRealPath("/");
    int count = process.setQuerySW(workshopid, categorycode, state, context, res_coid);
    ArrayList return_ex = new ArrayList();
    return_ex.add(count);
    return_ex.add(stateName);
    return_ex.add(workshopid);
    Gson gson = new Gson();
    gson.toJson(return_ex);
    out.print(gson.toJson(return_ex));

%>
