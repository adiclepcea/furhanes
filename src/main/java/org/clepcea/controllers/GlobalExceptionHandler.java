package org.clepcea.controllers;


import javax.naming.SizeLimitExceededException;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@ControllerAdvice
public class GlobalExceptionHandler {
	private static final Log logger = LogFactory.getLog(GlobalExceptionHandler.class);
	@ExceptionHandler(SizeLimitExceededException.class)
	@ResponseBody
	public String showSizeLimitExceededError(RedirectAttributes redirectAttributes,HttpServletResponse response, Exception ex){
		logger.info("Size toooooooooooooooooooooooooooooooooooooooooooooooooo large");
		response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		//response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		redirectAttributes.addFlashAttribute("message", "File size too large");
		return "File size too large ";
	}
	@ExceptionHandler(MaxUploadSizeExceededException.class)
	@ResponseBody
	public String showMaxUploadSizeExceededError(RedirectAttributes redirectAttributes, HttpServletResponse response, Exception ex){
		logger.info("Maaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaax");
		response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		redirectAttributes.addFlashAttribute("message", "File size too large");
		return "File size too large "+ex.getMessage();
	}
	
}
