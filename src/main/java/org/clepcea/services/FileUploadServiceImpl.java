package org.clepcea.services;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.naming.SizeLimitExceededException;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileUploadServiceImpl implements FileUploadService {

	@Override
	public String getFileExtension(String fileName) {
		String extension = "";

		int i = fileName.lastIndexOf('.');
		int p = Math.max(fileName.lastIndexOf('/'), fileName.lastIndexOf('\\'));
		
		if (i > p) {
		    extension = fileName.substring(i+1);
		}
		
		return extension;

	}

	@Override
	public String uploadFile(MultipartFile inFile, String outDir, String fileName) throws NullPointerException, IOException{
		String rezFileName = null;
		if (!inFile.isEmpty()) {
			byte[] bytes = inFile.getBytes();

			String rootPath = System.getenv("FURHANES_FILESTORE");
			
			if(rootPath==null){
				throw new NullPointerException("Please set the FURHANES_FILESTORE environment variable");
			}
			File dir = new File(rootPath + File.separator + outDir);
			if (!dir.exists()){
				dir.mkdirs();
			}
			
			if(!dir.exists()){
				throw new NullPointerException("No rights to write the file!");
			}
			
			rezFileName = dir.getAbsolutePath() + File.separator + fileName;
			File serverFile = new File(rezFileName);
			
			BufferedOutputStream stream = new BufferedOutputStream(
					new FileOutputStream(serverFile));
			stream.write(bytes);
			stream.flush();
			stream.close();
			
		}
		return rezFileName;
	}

	@Override
	public void deleteUploadedFile(String fileName) throws NullPointerException, IOException{
		
		File serverFile = new File(fileName);
		if(!serverFile.exists()){
			return;
		}
		serverFile.delete();
		
	}

}
