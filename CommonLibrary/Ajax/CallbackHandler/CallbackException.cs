﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CommonLibrary.Ajax.CallbackHandler
{
    /// <summary>
    /// Special return type used to indicate that an exception was
    /// fired on the server. This object is JSON serialized and the
    /// client can check for Result.IsCallbackError to see if a 
    /// a failure occured on the server.
    /// </summary>    
    public class CallbackException
    {
        public CallbackException()
        {
            message = string.Empty;
            stackTrace = string.Empty;
        }
        public bool isCallbackError { get; set; }
        public string message { get; set; }
        public string stackTrace { get; set; }
    }
    /// <summary>
    /// Special return type that can be used to return messages to the
    /// </summary>    
    public class CallbackMessage
    {
        public CallbackMessage()
        {
            message = string.Empty;
        }

        public bool isError { get; set; }
        public string message { get; set; }
        public object resultData { get; set; }
    }
}