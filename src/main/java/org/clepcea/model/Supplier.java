package org.clepcea.model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.joda.time.DateTime;
import org.joda.time.Days;

@Entity
@Table(name="SUPPLIERS")
public class Supplier implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2201840112035151110L;

	@Id
	@Column(name="id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	
	private String name, cui, address,j,bank,iban,swift,phone,fax,mail;
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="supplier")
	private List<Contact> contacts;
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="supplier")
	private List<Contract> contracts;
	
	public List<Contract> getContracts() {
		return contracts;
	}
	
	public void setContracts(List<Contract> contracts) {
		this.contracts = contracts;
	}
	
	public List<Contact> getContacts() {
		return contacts;
	}
	
	public void setContacts(List<Contact> contacts) {
		this.contacts = contacts;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getIban() {
		return iban;
	}

	public void setIban(String iban) {
		this.iban = iban;
	}

	public String getSwift() {
		return swift;
	}

	public void setSwift(String swift) {
		this.swift = swift;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getJ() {
		return j;
	}

	public void setJ(String j) {
		this.j = j;
	}

	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCui() {
		return cui;
	}

	public void setCui(String cui) {
		this.cui = cui;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	public boolean hasContractsToRenewInDays(int days){		
		return contracts.stream()
				.filter((contract)->(contract.mustRenewInDays(days)))
				.findAny().isPresent();
	}
	
	public boolean hasContractsToRenew(){
		return contracts.stream()
			.filter((contract)->(contract.mustRenew()))
			.findAny().isPresent();		
	}

}

