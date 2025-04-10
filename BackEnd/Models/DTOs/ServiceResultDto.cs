﻿namespace IntertenisClub.BusinessLogic.DTOs
{
    public class ServiceResult
    {
        public bool Succeeded { get; }  // Changed from Success to Succeeded
        public string Message { get; }
        public object? Data { get; }

        private ServiceResult(bool success, string message, object? data)
        {
            Succeeded = success;
            Message = message;
            Data = data;
        }

        public static ServiceResult Success(string message, object? data = null) =>
            new ServiceResult(true, message, data);

        public static ServiceResult Failure(string message) =>
            new ServiceResult(false, message, null);
    }
}