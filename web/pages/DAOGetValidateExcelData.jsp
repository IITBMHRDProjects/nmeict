<%@page import="org.project.bean.Institute"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.bean.State"%>
<%@page import="org.project.utilities.Validate"%>
<%@page import="org.project.bean.Stream"%>
<%@page import="org.project.bean.Qualification"%>
<%@page import="org.project.bean.Designation"%>
<%@page import="org.project.bean.Title"%>
<%-- 
    Document   : DAOGetValidateExcelData
    Created on : 23 Jun, 2015, 3:50:57 PM
    Author     : asl
--%>

<%@page import="org.project.utilities.ExcelRead"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.bean.Person"%>

<%
    try {
        String upid = request.getParameter("fileid");
        
        ArrayList<Person> perdata = null;
        Person person;
        ArrayList personsdata = new ArrayList();
        ExcelRead exr = new ExcelRead();
        String errormessage = "";
        int invl_count = 0, val_count = 0, total_count = 0;
        personsdata = exr.getAllPartRegData(Integer.parseInt(upid));
        total_count = personsdata.size();
        for (int i = 0; i < personsdata.size(); i++) {
            
            person = (org.project.bean.Person) personsdata.get(i);
            int flag = 0, flag2 = 0;
            int em_flag = 0, wid_flag = 0, fna_flag = 0, lna_flag = 0, istina_flag = 0;
            int titleid = 0, qualid = 0, desgid = 0, streamid = 0, stateid = 0;
            int check_vre = 0;
            if (!exr.isFieldEmpty(person.getEmail())) {
                flag++;
                errormessage = errormessage + "@Email Blank";
                em_flag = 1;
            } else if (exr.isFieldEmpty(person.getEmail())) {
                if (Validate.validateEmail(person.getEmail()) == false) {
                    flag++;
                    errormessage = errormessage + "@Email not valid";
                }
            }
            
            if (person.getPer_workshopid() == 0) {
                flag++;
                errormessage = errormessage + "@workshop id Blank";
                wid_flag = 1;
            } else if (person.getPer_workshopid() != 0) {
                
                int wid_res = 0;
                wid_res = exr.workshopidValid(person.getPer_workshopid());
                
                if (wid_res > 0) {
                    //next start date end date valid
                    int date_res = exr.checkDateOfWorkshop(person.getPer_workshopid());
                    if (date_res == 0) {
                        flag++;
                        errormessage = errormessage + "@Not in Workshop Register Date";
                    }
                } else {
                    flag++;
                    errormessage = errormessage + "@workshop id not found";
                }
            }
            
            if (!exr.isFieldEmpty(person.getFirstName())) {
                flag++;
                errormessage = errormessage + "@First Name Blank";
                fna_flag = 1;
            } else if (exr.isFieldEmpty(person.getFirstName())) {
                if (!Validate.isStringValid(person.getFirstName(), 2, 30) || !Validate.validateName(person.getFirstName())) {
                    flag++;
                    errormessage = errormessage + "@First Name not valid";
                }
            }
            
            if (!exr.isFieldEmpty(person.getLastName())) {
                flag++;
                errormessage = errormessage + "@Last Name Blank";
                lna_flag = 1;
            } else if (exr.isFieldEmpty(person.getLastName())) {
                if (!Validate.isStringValid(person.getLastName(), 1, 30) || !Validate.validateLastName(person.getLastName())) {
                    flag++;
                    errormessage = errormessage + "@Last Name not valid";
                }
            }
            
            if (!exr.isFieldEmpty(person.getInstitute().getInstituteName())) {
                flag++;
                errormessage = errormessage + "@institute Name Blank";
                istina_flag = 1;
            } else if (exr.isFieldEmpty(person.getInstitute().getInstituteName())) {
                if (!Validate.validateInstitute(person.getInstitute().getInstituteName())) {
                    flag++;
                    errormessage = errormessage + "@institute name not valid";
                } else {
                    int instituteid = 0;
                    instituteid = exr.getvalidIdOfField(person, "institute");
                    if (instituteid > 0) {
                        Institute institue = new Institute();
                        institue.setInstituteId(instituteid);
                        person.setInstitute(institue);
                    }
                }
            }
            
            if (person.getRemoteCenter().getRemoteCenterId() == 0) {
                flag++;
                errormessage = errormessage + "@rcid Blank";
            }else if(person.getRemoteCenter().getRemoteCenterId() != 0)
            {
                 boolean res_rc=exr.check_RcIdExist(person.getRemoteCenter().getRemoteCenterId());
                 if(res_rc == false){
                  flag++;
                  errormessage = errormessage + "@rcid does not exist in database";
                 }
            }

            //   if (em_flag == 0 && wid_flag == 0 && fna_flag == 0 && lna_flag == 0 && istina_flag == 0) {
            if (errormessage.equals("")) {
                
                check_vre = exr.checkValidDataExist(person);
                
                if (check_vre > 0) {
                    errormessage = errormessage + "@duplicate entry";
                    person.setPer_errormessage(errormessage);
                    flag++;
                } else if (check_vre == 0) {
                    //mandatory field filled

                    if (exr.isFieldEmpty(person.getTitle().getTitleName())) {
                        
                        titleid = exr.getvalidIdOfField(person, "title");
                        if (titleid > 0) {
                            Title title = new Title();
                            title.setTitleId(titleid);
                            person.setTitle(title);
                        } else if (titleid == 0) {
                            flag++;
                            errormessage = errormessage + "@title not match";
                        }
                    }
                    
                    if (exr.isFieldEmpty(person.getQualification().getQualification())) {
                        qualid = exr.getvalidIdOfField(person, "qualification");
                        if (qualid > 0) {
                            Qualification qual = new Qualification();
                            qual.setQualificationId(qualid);
                            person.setQualification(qual);
                        } else if (qualid == 0) {
                            flag++;
                            errormessage = errormessage + "@qualification not match";
                        }
                    }
                    
                    if (exr.isFieldEmpty(person.getDesignation().getDesignationName())) {
                        desgid = exr.getvalidIdOfField(person, "designation");
                        if (desgid > 0) {
                            Designation desg = new Designation();
                            desg.setDesignationId(desgid);
                            person.setDesignation(desg);
                        } else if (desgid == 0) {
                            flag++;
                            errormessage = errormessage + "@desgination not match";
                        }
                    }
                    
                    if (exr.isFieldEmpty(person.getStream().getStreamName())) {
                        streamid = exr.getvalidIdOfField(person, "discipline");
                        if (streamid > 0) {
                            Stream stream = new Stream();
                            stream.setStreamId(streamid);
                            person.setStream(stream);
                        } else if (streamid == 0) {
                            flag++;
                            errormessage = errormessage + "@discipline not match";
                        }
                    }
                    
                    if (exr.isFieldEmpty(person.getExperience())) {
                        
                        boolean result = exr.checkExperince(person.getExperience().trim());
                        if (result == false) {
                            flag++;
                            errormessage = errormessage + "@experience not valid";
                        }
                        // if (!person.getExperience().trim().equals("0-2 years") || !person.getExperience().equals("2-5 years") || !person.getExperience().equals("5-10 years") || !person.getExperience().equals(">10 years")) {
                        //     flag++;
                        //     errormessage = errormessage + "@experience not valid";
                        //  }
                    }
                    
                    if (exr.isFieldEmpty(person.getGender())) {
                        boolean result = exr.checkGender(person.getGender().trim());
                        if (result == false) {
                            flag++;
                            errormessage = errormessage + "@Gender not valid";
                        }
                        // if (!person.getGender().equals("M") || !person.getGender().equals("F")) {
                        //      flag++;
                        //       errormessage = errormessage + "@Gender not valid";
                        //  }
                    }
                    
                    if (exr.isFieldEmpty(person.getAddress())) {
                        if ((person.getAddress().equals("")) || !Validate.validateAddress(person.getAddress())) {
                            flag++;
                            errormessage = errormessage + "@Address not valid";
                        }
                    }
                    
                    if (exr.isFieldEmpty(person.getPer_state())) {
                        stateid = exr.getvalidIdOfField(person, "state");
                        if (stateid > 0) {
                            person.setStateId(stateid);
                        } else {
                            flag++;
                            errormessage = errormessage + "@State not valid";
                        }
                    }
                    
                    if (person.getPincode() != 0) {
                        if (Validate.validatePincode(String.valueOf(person.getPincode())) == false) {
                            flag++;
                            errormessage = errormessage + "@Pincode not valid";
                        }
                    }
                    
                    if (exr.isFieldEmpty(person.getMobileNumber())) {
                        
                        if (Validate.validateMobileNumber(String.valueOf(person.getMobileNumber())) == false) {
                            flag++;
                            errormessage = errormessage + "@Mobile not valid";
                        }
                    }
                    
                    if (exr.isFieldEmpty(person.getPhoneNumber())) {
                        if (Validate.validatePhoneNumber("0" + person.getPhoneNumber()) == false) {
                            flag++;
                            errormessage = errormessage + "@Phone not valid";
                        }
                    }
                    
                }
            }
            
            if (flag > 0) {
                person.setPer_errormessage(errormessage);
                person.setPer_userstatus("error");
                int res2 = exr.invalidDataMessage(person);
                if (res2 > 0) {
                    invl_count++;
                }
            } else if (flag == 0) {
                //valid data
                person.setPer_userstatus("valid");
                int res3 = exr.validData(person);
                if (res3 > 0) {
                    val_count++;
                }
            }
            errormessage = "";
        }
        
        String out_res = +total_count + "#" + val_count + "#" + invl_count;
        Gson gson = new Gson();
        gson.toJson(out_res);
        out.print(gson.toJson(out_res));
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
