package org.clepcea.services;

import java.io.IOException;

import javax.naming.SizeLimitExceededException;

import org.springframework.web.multipart.MultipartFile;

public interface FileUploadService {
	public String getFileExtension(String fileName);
	public String uploadFile(MultipartFile inFile, String outDir, String fileName) throws NullPointerException, IOException;
	public void deleteUploadedFile(String fileName) throws NullPointerException, IOException;
}
