package fi.hut.soberit.agilefant.util;

import java.util.ArrayList;
import java.util.List;

import fi.hut.soberit.agilefant.model.Backlog;

/**
 * A class representing a backlog node in the timesheet tree.
 * Holds other backlogs and stories      (separately) as its children.
 * With its superclass it calculates the effort spent for this backlog and its children.
 *  
 * @author Pasi Pekkanen, Vesa Pirilä
 *
 */
public class BacklogTimesheetNode extends TimesheetNode {
    List<BacklogTimesheetNode> childBacklogs = new ArrayList<BacklogTimesheetNode>();
    List<StoryTimesheetNode> childStories = new ArrayList<StoryTimesheetNode>();
    List<TaskTimesheetNode> childTasks = new ArrayList<TaskTimesheetNode>();
    Backlog backlog;
    
    public BacklogTimesheetNode(Backlog backlog) {
        super();
        this.backlog = backlog;
    }
    @Override
    public List<? extends TimesheetNode> getChildren() {
        List<TimesheetNode> children = new ArrayList<TimesheetNode>();
        children.addAll(this.childBacklogs);
        children.addAll(this.childStories);
        children.addAll(this.childTasks);
        return children;
    }
    @Override
    public String getName() {
        return this.backlog.getName();
    }
    @Override
    public boolean getHasChildren() {
        return (this.childBacklogs.size() > 0 || this.childStories.size() > 0 || this.childTasks.size() > 0);
    }
    @Override
    public int getId() {
        return backlog.getId();
    }
    
    public Backlog getBacklog() {
        return this.backlog;
    }
    
    public List<StoryTimesheetNode> getStoryNodes() {
        return this.childStories;
    }
    public void addChild(StoryTimesheetNode storyNode) {
        this.childStories.add(storyNode);
    }
    
    public void addChild(TaskTimesheetNode taskNode) {
        this.childTasks.add(taskNode);
    }
    public void addChild(BacklogTimesheetNode backlogNode) {
        this.childBacklogs.add(backlogNode);
    }
    
    public List<TaskTimesheetNode> getTaskNodes() {
        return this.childTasks;
    }
    public List<BacklogTimesheetNode> getBacklogNodes() {
        return this.childBacklogs;
    }
    

}