package com.tasks;

public class Task {
	int idt;
	String name;
	String priority;
	String description;
	Double timeToDo;
	public int getIdt() {
		return idt;
	}
	public void setIdt(int idt) {
		this.idt = idt;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}

	public Double getTimeToDo() {
		return timeToDo;
	}
	public void setTimeToDo(Double timeToDo) {
		this.timeToDo = timeToDo;
	
	}
	public void setDescription(String string) {
		// TODO Auto-generated method stub
		this.description = string;
		
	}
	
	public String getDescription() {
		return description;
	}
	
}
