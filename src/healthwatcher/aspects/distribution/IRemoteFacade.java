package healthwatcher.aspects.distribution;

import healthwatcher.model.complaint.Complaint;
import healthwatcher.model.complaint.DiseaseType;
import healthwatcher.model.employee.Employee;
import healthwatcher.model.healthguide.HealthUnit;

import java.io.Serializable;
import java.rmi.Remote;
import java.rmi.RemoteException;

import lib.exceptions.ObjectAlreadyInsertedException;
import lib.exceptions.ObjectNotFoundException;
import lib.exceptions.ObjectNotValidException;
import lib.exceptions.RepositoryException;
import lib.exceptions.UpdateEntryException;
import lib.util.IteratorDsk;

/**
 * A remote facade for use with rmi
 * This is just a copy of IFacade but throwing remote exception in every method
 */
public interface IRemoteFacade extends Remote, Serializable {

	public void updateComplaint(Complaint q) throws RepositoryException, ObjectNotFoundException,
			ObjectNotValidException, RemoteException;

	public IteratorDsk searchSpecialitiesByHealthUnit(int code) throws ObjectNotFoundException,
			RepositoryException, RemoteException;

	public Complaint searchComplaint(int code) throws RepositoryException, ObjectNotFoundException, RemoteException;

	public DiseaseType searchDiseaseType(int code) throws RepositoryException,
			ObjectNotFoundException, RemoteException;

	public IteratorDsk searchHealthUnitsBySpeciality(int code) throws ObjectNotFoundException,
			RepositoryException, RemoteException;

	public IteratorDsk getSpecialityList() throws RepositoryException, ObjectNotFoundException, RemoteException;

	public IteratorDsk getDiseaseTypeList() throws RepositoryException, ObjectNotFoundException, RemoteException;

	public IteratorDsk getHealthUnitList() throws RepositoryException, ObjectNotFoundException, RemoteException;

	public IteratorDsk getPartialHealthUnitList() throws RepositoryException,
			ObjectNotFoundException, RemoteException;

	public int insertComplaint(Complaint complaint) throws RepositoryException,
			ObjectAlreadyInsertedException, ObjectNotValidException, RemoteException;

	public void updateHealthUnit(HealthUnit unit) throws RepositoryException,
			ObjectNotFoundException, ObjectNotValidException, RemoteException;

	public IteratorDsk getComplaintList() throws RepositoryException, ObjectNotFoundException, RemoteException;

	public void insert(Employee e) throws ObjectAlreadyInsertedException, ObjectNotValidException,
			RepositoryException, RemoteException;

	public void updateEmployee(Employee e) throws RepositoryException, ObjectNotFoundException,
			ObjectNotValidException, UpdateEntryException, RemoteException;

	public Employee searchEmployee(String login) throws RepositoryException,
			ObjectNotFoundException, ObjectNotValidException, UpdateEntryException, RemoteException;

	public HealthUnit searchHealthUnit(int healthUnitCode) throws ObjectNotFoundException,
			RepositoryException, RemoteException;
}
