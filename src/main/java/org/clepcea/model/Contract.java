package org.clepcea.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name="Contracts")
public class Contract implements Serializable{
	/**
	 * 
	 */
	@Transient
	private MultipartFile file;
	
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	private static final long serialVersionUID = 3765615611879474697L;
	@Id
	@Column(name="ID")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	@ManyToOne
	@JoinColumn(name="SUPPLIERS_ID",nullable=false)
	@JsonBackReference
	private Supplier supplier;
	@Column(name="CONTRACT_DATE")
	private Date contractDate;
    @Column(name="INTERNAL_NUMBER")
	private int internalNumber;
    @Column(name="EXPIRATION_DATE")
	private Date expirationDate;
	@Column(name="UNDEFINITE")
	private boolean undefinite;
    @Column(name="CONTRACT_OBJECT")
    private String contractObject;
    @Column(name="CONTACT_PERSON")
    private long contactPerson;
    @Column(name="FILED")
    private String filed;
    @Column(name="PAYMENT_TERM")
    private int paymentTerm;
    @Column(name="SCAN_FILE")
    private String scanFile;
    @Column(name="ORIGINAL_FILE_NAME")
    private String originalFileName;
    @Column(name="OBSERVATIONS")
    private String observations;
    @Column(name="DO_NOT_RENEW")
    private boolean doNotRenew;
    
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public Supplier getSupplier() {
		return supplier;
	}
	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}
	public Date getContractDate() {
		return contractDate;
	}
	public void setContractDate(Date cotractDate) {
		this.contractDate = cotractDate;
	}
	public int getInternalNumber() {
		return internalNumber;
	}
	public void setInternalNumber(int internalNumber) {
		this.internalNumber = internalNumber;
	}
	public Date getExpirationDate() {
		return expirationDate;
	}
	public void setExpirationDate(Date expirationDate) {
		this.expirationDate = expirationDate;
	}
	public boolean isUndefinite() {
		return undefinite;
	}
	public void setUndefinite(boolean undefinite) {
		this.undefinite = undefinite;
	}
	public String getContractObject() {
		return contractObject;
	}
	public void setContractObject(String contractObject) {
		this.contractObject = contractObject;
	}
	public long getContactPerson() {
		return contactPerson;
	}
	public void setContactPerson(long contactPerson) {
		this.contactPerson = contactPerson;
	}
	public String getFiled() {
		return filed;
	}
	public void setFiled(String filed) {
		this.filed = filed;
	}
	public int getPaymentTerm() {
		return paymentTerm;
	}
	public void setPaymentTerm(int paymentTerm) {
		this.paymentTerm = paymentTerm;
	}
	public String getScanFile() {
		return scanFile;
	}
	public void setScanFile(String scanFile) {
		this.scanFile = scanFile;
	}
	public String getOriginalFileName() {
		return originalFileName;
	}
	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	public String getObservations() {
		return observations;
	}
	public void setObservations(String observations) {
		this.observations = observations;
	}
	public boolean isDoNotRenew() {
		return doNotRenew;
	}
	public void setDoNotRenew(boolean doNotRenew) {
		this.doNotRenew = doNotRenew;
	}
	
}
