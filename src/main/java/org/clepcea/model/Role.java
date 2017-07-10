package org.clepcea.model;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="ROLES")
public class Role implements java.io.Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7348257323076831018L;

	@Id
	@Column(name="ID")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	
	@Column(name="NAME")
	private String name;
	
	@OneToMany
	@JoinTable(
			name="ROLES2RIGHTS",
			joinColumns = @JoinColumn(name="ROLES_ID"),
			inverseJoinColumns = @JoinColumn(name="RIGHTS_ID"))
	private Set<Right> rights;
	
	public Set<Right> getRights() {
		return rights;
	}
	public void setRights(Set<Right> rights) {
		this.rights = rights;
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
}
