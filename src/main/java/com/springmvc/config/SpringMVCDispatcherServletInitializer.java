package com.springmvc.config;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import jakarta.servlet.Filter;
import jakarta.servlet.MultipartConfigElement;
import jakarta.servlet.ServletRegistration;
import org.springframework.lang.NonNull;

public class SpringMVCDispatcherServletInitializer extends
		AbstractAnnotationConfigDispatcherServletInitializer {

	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class[0];
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		return new Class[] { WebConfig.class };
	}

	@Override
	@NonNull
	protected String[] getServletMappings() {
		return new String[] { "/" };
	}

	@Override
	protected Filter[] getServletFilters() {
		CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
		characterEncodingFilter.setEncoding("UTF-8");
		characterEncodingFilter.setForceEncoding(true);
		return new Filter[] { characterEncodingFilter };
	}

	// เพิ่มตรงนี้สำหรับ Multipart
	@Override
	protected void customizeRegistration(@NonNull ServletRegistration.Dynamic registration) {
		MultipartConfigElement multipartConfig = new MultipartConfigElement(
				"C:/img_tutor", // temp folder ต้องมีอยู่จริง
				5242880, // max file size = 5MB
				10485760, // max request size = 10MB
				0 // fileSizeThreshold
		);
		registration.setMultipartConfig(multipartConfig);
	}
}
