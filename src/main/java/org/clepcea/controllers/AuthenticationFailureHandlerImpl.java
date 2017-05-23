package org.clepcea.controllers;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;

@Component
public class AuthenticationFailureHandlerImpl extends SimpleUrlAuthenticationFailureHandler {
	private final Logger LOGGER = Logger.getLogger(this.getClass().getName());
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException ex)
			throws IOException, ServletException {
		
		if(ex.getMessage().toLowerCase().equals("bad credentials")){
			response.setStatus(HttpServletResponse.SC_FORBIDDEN);
			response.sendRedirect("/furhanes/login/?error=Invalid%20credentials%20supplied");
			LOGGER.info("Invalid credentials supplied");
		}else if(ex.getCause()!=null){
			LOGGER.severe(ex.getCause().getMessage());
			if(ex.getCause().getClass().getName().indexOf("JdbcConnectionException")>1){				
				response.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
				response.sendRedirect("/furhanes/login/?error=DB%20Connection%20exception");
			}else{
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				response.sendRedirect("/furhanes/login/?error="+ex.getCause().getClass().getName());
			}
			
		}
		
	}

}
