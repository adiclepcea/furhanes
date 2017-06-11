package org.clepcea.services;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.clepcea.dao.ContractDao;
import org.clepcea.model.Contract;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ContractServiceImpl implements ContractService {

	@Autowired
	private ContractDao contractDao;
	@Override
	public void saveContract(Contract contract) {
		
		contractDao.save(contract);
	}

	@Override
	public List<Contract> listContracts(int start, int count, Map<String, Object> filter) {
		return contractDao.list(start, count,filter);
	}

	@Override
	public Contract getContractById(long id) {
		return contractDao.getById(id);
	}

	@Override
	public void deleteContractById(long id) {
		contractDao.deleteById(id);
	}
	
	@Override
	public  Map<String, Long> getStatistics(){
		Map<String,Long> map = new HashMap<>();
		map.put("expired", contractDao.getExpiredContractsCount());
		map.put("expiring", contractDao.getExpiringContractsCount());
		map.put("running", contractDao.getRunningContractsCount());
		map.put("finished", contractDao.getFinishedContractsCount());
		
		return map;
	}
	
	@Override
	public void writeListToExcel(int start, int count, Map<String, Object> filter, OutputStream os) throws IOException{
		List<Contract> listContracts= listContracts(start, count, filter);
		Workbook wkbook = new HSSFWorkbook();
		CreationHelper createHelper = wkbook.getCreationHelper();
		Sheet sh = wkbook.createSheet("Contracts");
		int rowPos = 0;
		Row r = sh.createRow(rowPos++);
		Font font = wkbook.createFont();
		font.setBold(true);
		CellStyle headerStyle = wkbook.createCellStyle();
		headerStyle.setFont(font);
		r.createCell(0).setCellValue("Supplier");
		r.createCell(1).setCellValue("Contract date");
		r.createCell(2).setCellValue("Internal number");
		r.createCell(3).setCellValue("Expiration date");
		r.createCell(4).setCellValue("Contract object");
		r.createCell(5).setCellValue("Undefinite");
		r.createCell(6).setCellValue("Do not renew");
		r.createCell(7).setCellValue("Filed");
		r.createCell(8).setCellValue("Payment Term");
		for(int i=0;i<=8;i++){
			r.getCell(i).setCellStyle(headerStyle);
		}
		CellStyle csDate=wkbook.createCellStyle();
		csDate.setDataFormat(createHelper.createDataFormat().getFormat("dd.mm.yy"));
		for(Contract contract:listContracts){
			Row row = sh.createRow(rowPos++);
			Cell cell = row.createCell(0);
			cell.setCellValue(contract.getSupplier().getName());
			Cell cell1 = row.createCell(1);
			cell1.setCellValue(contract.getContractDate());
			cell1.setCellStyle(csDate);
			Cell cell2 = row.createCell(2);
			cell2.setCellValue(contract.getInternalNumber());
			Cell cell3 = row.createCell(3);
			if(contract.getExpirationDate()==null){
				cell3.setCellValue("");
			}else{
				cell3.setCellValue(contract.getExpirationDate());
				cell3.setCellStyle(csDate);
			}
			
			Cell cell4 = row.createCell(4);
			cell4.setCellValue(contract.getContractObject());
			Cell cell5 = row.createCell(5);
			cell5.setCellValue(contract.isUndefinite());
			Cell cell6 = row.createCell(6);
			cell6.setCellValue(contract.isDoNotRenew());
			Cell cell7 = row.createCell(7);
			cell7.setCellValue(contract.getFiled());
			Cell cell8 = row.createCell(8);
			cell8.setCellValue(contract.getPaymentTerm());
		}
		
		wkbook.write(os);
		wkbook.close();
	}

}
