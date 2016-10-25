/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.utilities;

/**
 *
 * @author mayank
 */
public interface ErrorCode {
    /*
     * declaring error codes
     */

    public static final int SUCCESS = 0;
    public static final int ERROR = 1;
    public static final int EXCEPTION = 2;
    public static final int NULLPOINTEREXCEPTION = 3;
    public static final int SQLEXCEPTION = 4;
    public static final int INDEXOUTOFBOUNDEXCEPTION = 5;
    public static final int CLASSCASTEXCEPTION = 6;
    public static final int IOEXCEPTION = 7;
    public static final int CLASSNOTFOUNDEXCEPTION = 8;
    public static final int NUMBERFORMATEXCEPTION = 9;
    
    public static final String[] ERROR_MESSAGE = {"SUCCESS", "ERROR", "EXCEPTION",
                        "NULLPOINTEREXCEPTION", "SQLEXCEPTION", "INDEXOUTOFBOUNDEXCEPTION",
                        "CLASSCASTEXCEPTION", "IOEXCEPTION", "CLASSNOTFOUNDEXCEPTION",
                        "NUMBERFORMATEXCEPTION"};
}
