/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.validate;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author asl
 */
public class Validate {
     /*
     * isStringValid() method is used to check that the given string is not null and
     * it's length is in a given range.
     * If given string is not null and it's length is in a given range return true otherwise false.
     * @param (String) Given string to be checked for validity.
     * @param (int) Minimum length of the string.
     * @param (int) Maximum length of the string.
     * @return (boolean) true or false depending on the validity of the string is returned.
     */
    /**
     *
     * @param string A string object
     * @param minLength A int object
     * @param maxLength A int object
     * @return result boolean true or false depending on the validity of the string.
     */
    public static boolean isStringValid(String string, int minLength, int maxLength) {
        boolean result = false;
        if(string != null && !string.trim().isEmpty()) { // check for null or empty string
            // check the length of the string is within range or not.
            if(string.trim().length()>=minLength && string.trim().length() <=maxLength) {
                //set result to true.
                result = true;
            }
        }
        return result;
    }

    /*
     * isStringValid() method is used to check that the given string is not null and
     * it's length is in a given range.
     * If given string is not null and it's length is in a given range return true otherwise false.
     * @param (String) Given string to be checked for validity.
     * @return (boolean) true or false depending on the validity of the string is returned.
     */
    /**
     *
     * @param string A string object
     * @return result boolean true or false depending on the validity of the string.
     */
    public static boolean isStringValid(String string) {
        boolean result = false;
        if(string != null && !string.trim().isEmpty()) { // check for null or empty string
            result = true;
        }
        return result;
    }

    /**
     *
     * @param num A string object
     * @return result boolean true or false depending on the validity of the string.
     */
    public static boolean isNumber(String num) {
        boolean result = false;
        String regexp = "^[7-9][0-9]*$";
        if(!num.matches(regexp))
        {
            result = true;
        }
        return result;
    }

    /*
     * validateEmail() function is used to validate the email address.
     * It checks whether the given email address is in correct format or not.
     * If the address is in correct format it return true otherwise false.
     * @param (String) email address string to be checked for validity.
     * @return (boolean) true or false depending on the validity of the email address.
     */
    /**
     *
     * @param email A string object
     * @return result boolean true or false depending on the validity of the string.
     */
    public static boolean validateEmail(String email) {
        boolean matchFound = false;
        if(email != null && !email.trim().isEmpty()) {
            //Set the email pattern string
            Pattern p = Pattern.compile(".+@.+\\.[a-z]+");
            //Match the given string with the pattern
            Matcher m = p.matcher(email);
            //check whether match is found
            matchFound = m.matches();
        }
        return matchFound;

    }

    /*
     * validateURL() function is used to validate the URL address.
     * It checks whether the given URL address is in correct format or not.
     * If the address is in correct format it return true otherwise false.
     * @param (String) URL address string to be checked for validity.
     * @return (boolean) true or false depending on the validity of the URL address.
     */
    /**
     *
     * @param URL A string object
     * @return result boolean true or false depending on the validity of the string.
     */
    public static boolean validateURL(String url) {
     /* principalname should be at least 5 character long (at most 15) with alphabets, digits and (),.- */
    boolean result=(url !=null) && (url.length() >= 1) && (url.length() <= 50) && (url.matches("^[A-Za-z /-\\:_.-]*$") && (url.trim().length() > 0));
    return result;
    }

    /*
     * validateMobileNumber() method is used to check the validity of mobile number.
     * It check whether the mobile number is in correct format or not. If mobile number
     * is 10 digit, it should not start with 0 or if it is 11 digit then it should start
     * with a zero. It also checks whether mobile number begins with 7,8 or 9.
     * @param (String) A mobile number as a string
     * @return (boolean) true or false depending on the validity of the mobile number.
     */
    /**
     *
     * @param mobilenumber A string object
     * @return result boolean true or false depending on the validity of the string.
     */
    public static boolean validateMobileNumber(String mobilenumber) {
        /* mobilenumber should be 10 digits (beginning 9/8/7) long (at most 11 if beginning 0) */
        boolean result = (mobilenumber != null) &&
                         (mobilenumber.length() > 0) &&
                         (((mobilenumber.length() == 10) && (mobilenumber.matches("^[7-9][0-9]*$"))) ||
                         ((mobilenumber.length() == 11) && (mobilenumber.matches("^[0][7-9][0-9]*$"))));
        return result;
    }

    
    /**
     * isAllAlphabet() method is used to check the string that string only have alphabets.
     * It check whether the string have only alphabets or not.
     * @param string
     * @return
     */
    public static boolean isAllAlphabet(String string) {
        boolean result = false;
        //regular expression to check that given string only have alphabets.
        String alphaExp = "^[a-zA-Z]+$";
        //checking with regular expression
        result = string.matches(alphaExp);
        //returning the result
        return result;
    }
    /**
     * This method is used to check the string that string should only have alphabets, space and dot(.).
     * It check whether the string have only alphabets, space and dot(.) or not, if not then return false.
     * It also check occureance of two consecutive space or dot(.), if found then return false.
     * It also check whether string starts with alphabet or not, if not then return false.
     *
     @param string A string object
     *
     @return result boolean true or false depending on the validity of the string.
     *
     */
    public static boolean validateUserName(String string) {
        boolean result = false;
        String dispNameExp = "^[a-zA-Z][a-zA-Z/. ]+[a-zA-Z]+$";
        result = string.matches(dispNameExp);
        if(result) {
            char previous = string.charAt(0);
            char current;
        for(int i=1;i<string.length();i++) {
            current = string.charAt(i);
            if(previous == current && previous == ' ') {
                return false;
            }
            previous = current;
        }
        }
        return result;
    }
    /**
     * This method is used to check the string that string should only have alphabets, numbers, period (.) and underscore(_).
     * It check whether the string have only alphabets, numbers, period(.), underscore(_) or not, if not then return false.
     * It also check occureance of two consecutive special characters, if found then return false.
     * It also check whether string starts with alphabet or not, if not then return false.
     *
     @param string A string object
     *
     @return boolean true or false depending on the validity of the string.
     *
     */
    public static boolean validateUserId(String string) {
        boolean result = false;
        String  userIdExp = "^[a-zA-Z][a-zA-Z0-9/./_]+[a-zA-Z0-9]+$";
        result = string.matches(userIdExp);
        if(result) {
            char previous = string.charAt(0);
            char current;
            int specialChar = 0;
            for(int i=1;i<string.length();i++) {
                current = string.charAt(i);
                if(previous == current && (previous == '.' || previous == '_')) {
                    return false;
                } else if(previous == '.' && current == '_') {
                    return false;
                } else if(previous == '_' && current == '.') {
                    return false;
                }
                previous = current;
            }
        }
        return result;
    }

    /**
     * This method is used to check the string that string should only have alphabets and space.
     * It check whether the string have only alphabets and space or not, if not then return false.
     * It also check occureance of two consecutive space, if found then return false.
     * It also check whether string starts with alphabet or not, if not then return false.
     *
     @param string A string object
     *
     @return boolean true or false depending on the validity of the string.
     *
     */
    public static boolean validateName(String string) {
        boolean result = false;
        String dispNameExp = "^[a-zA-Z][a-zA-Z. ]+[a-zA-Z]+$";
        result = string.matches(dispNameExp);
        if(result) {
            char previous = string.charAt(0);
            char current;
        for(int i=1;i<string.length();i++) {
            current = string.charAt(i);
            if(previous == current && previous == ' ') {
                return false;
            }
            previous = current;
        }
        }
        return result;
    }

    /**
     * This method is used to check the string that string should only have alphabets and space.
     * It check whether the string have only alphabets and space or not, if not then return false.
     * It also check occurrence of two consecutive space, if found then return false.
     * It also check whether string starts with alphabet or not, if not then return false.
     *
     @param string A string object
     *
     @return boolean true or false depending on the validity of the string.
     *
     */
    public static boolean validateDisplayName(String string) {
        boolean result = false;
        String dispNameExp = "^[a-zA-Z][a-zA-Z ]+[a-zA-Z]+$";
        result = string.matches(dispNameExp);
        if(result) {
            char previous = string.charAt(0);
            char current;
        for(int i=1;i<string.length();i++) {
            current = string.charAt(i);
            if(previous == current && previous == ' ') {
                return false;
            }
            previous = current;
        }
        }
        return result;
    }

    /**
     * This method is used to check the string that string should can have alphabets and numbers.
     * It check whether the string have alphabets, digits and space or not, if not then return false.
     *
     @param string A string object
     *
     @return boolean true or false depending on the validity of the string.
     *
     */
    public static boolean validateAddress(String string) {
        boolean result = false;
        string = string.trim();
        String dispNameExp = "^[A-Za-z0-9 .\r\n\\/()&:',_-]*$";
        result = string.matches(dispNameExp);
        if(result) {
            char previous = string.charAt(0);
            char current;
        for(int i=1;i<string.length();i++) {
            current = string.charAt(i);
            if(previous == current && previous == ' ') {
                for(int j=i;j<string.length()-1;j++) {
                    string.replace(string.charAt(j), string.charAt(j+1));
                }
            }
            previous = current;
        }
        }
        return result;
    }

    /**
     * to check white space and remove
     * @param str A string object
     * @return reducedstr String
     */
    public static String alltrim(String str)
    {
        String reducedstr;
        reducedstr = str.trim();
        return reducedstr;
    }


    /**
     * Validate whether given string is number or not
     * @param number A string object
     * @return result as true is number is valid number otherwise false.
     */
    public static boolean validatenumber(String number)
{
        boolean result = false;
        if((number != null)&& (number.length() <= 12) && (number.length() >= 5) && (number.matches("^[0-9]*$")))
          result = true;
        return result;
}


    /**
     * Validate whether given string is number or not
     * @param number A string object
     * @return result as true is number is valid number otherwise false.
     */
    public static boolean validatestd(String number)
{
        boolean result = false;
        if((number != null)&& (number.length() <= 6) && (number.length() >= 3) && (number.matches("^[0-9]*$")))
          result = true;
        return result;
}
}
