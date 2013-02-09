package com.tasks;

public class Task {
    private int idt;
	private String name;
    private String priority;
    private String description;
    private Double timeToDo;
    private int projectId;
    private int userId;

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

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public int getProjectId() {
        return projectId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int usertId) {
        this.userId = usertId;
    }
}
