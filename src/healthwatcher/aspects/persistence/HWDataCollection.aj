package healthwatcher.aspects.persistence;

import healthwatcher.Constants;
import healthwatcher.business.complaint.ComplaintRecord;
import healthwatcher.business.complaint.DiseaseRecord;
import healthwatcher.business.employee.EmployeeRecord;
import healthwatcher.business.healthguide.HealthUnitRecord;
import healthwatcher.business.healthguide.MedicalSpecialityRecord;
import healthwatcher.data.IComplaintRepository;
import healthwatcher.data.IDiseaseRepository;
import healthwatcher.data.IEmployeeRepository;
import healthwatcher.data.IHealthUnitRepository;
import healthwatcher.data.ISpecialityRepository;
import healthwatcher.data.mem.ComplaintRepositoryArray;
import healthwatcher.data.mem.DiseaseTypeRepositoryArray;
import healthwatcher.data.mem.EmployeeRepositoryArray;
import healthwatcher.data.mem.HealthUnitRepositoryArray;
import healthwatcher.data.mem.SpecialityRepositoryArray;
import healthwatcher.data.rdb.ComplaintRepositoryRDB;
import healthwatcher.data.rdb.DiseaseTypeRepositoryRDB;
import healthwatcher.data.rdb.EmployeeRepositoryRDB;
import healthwatcher.data.rdb.HealthUnitRepositoryRDB;
import healthwatcher.data.rdb.SpecialityRepositoryRDB;
import lib.exceptions.RepositoryException;
import lib.persistence.IPersistenceMechanism;

/**
 * This aspect intercepts Record creations and inserts Records with the proper repository
 * instance, depending if it is persistent or not
 */
public aspect HWDataCollection {
	
	private interface SystemRecord {};
	
	declare parents: ComplaintRecord ||
					 MedicalSpecialityRecord ||
					 HealthUnitRecord ||
					 EmployeeRecord ||
					 DiseaseRecord implements SystemRecord;

	Object around(): call(SystemRecord+.new(..)) &&	! within(HWDataCollection+) {
		return getSystemRecord(thisJoinPoint.getSignature().getDeclaringType());
	}
	

    declare soft: RepositoryException : execution(* SystemRecord+.*(..));
    
	/**
	 * Creates a system record depending on the class type
	 */
	protected SystemRecord getSystemRecord(Class type) {

		if (type.equals(ComplaintRecord.class)) {
			return new ComplaintRecord(getComplaintRepository());
		} else  if (type.equals(HealthUnitRecord.class)) {
			return new HealthUnitRecord(getHealthUnitRepository());
		} else  if (type.equals(MedicalSpecialityRecord.class)) {
			return new MedicalSpecialityRecord(getSpecialityRepository());
		} else  if (type.equals(EmployeeRecord.class)) {
			return new EmployeeRecord(getEmployeeRepository());
		}else if(type.equals(DiseaseRecord.class)){
			return new DiseaseRecord(getDiseaseRepository());
		}
		return null;
	}

	// Methods to create repository for each class type. The repository
	// created depend if the system in persistent or not
	
	protected IComplaintRepository getComplaintRepository() {
		if (Constants.isPersistent()) {
			return new ComplaintRepositoryRDB(getPm());
		}
    	return new ComplaintRepositoryArray();
    }
    
    protected ISpecialityRepository getSpecialityRepository() {
    	if (Constants.isPersistent()) {
			return new SpecialityRepositoryRDB(getPm());
		}
    	return new SpecialityRepositoryArray();
    }
    
    protected IHealthUnitRepository getHealthUnitRepository() {
    	if (Constants.isPersistent()) {
			return new HealthUnitRepositoryRDB(getPm());
		}
    	return new HealthUnitRepositoryArray();
    }
    
	protected IDiseaseRepository getDiseaseRepository()  {
		if (Constants.isPersistent()) {
			return new DiseaseTypeRepositoryRDB(getPm());
		}
    	return new DiseaseTypeRepositoryArray();
    }
    
 	protected IEmployeeRepository getEmployeeRepository()  {
 		if (Constants.isPersistent()) {
			return new EmployeeRepositoryRDB(getPm());
		}
    	return new EmployeeRepositoryArray();
    }
 	
 	/**
 	 * Returns the persistence mechanism in use
 	 */
 	protected IPersistenceMechanism getPm() {
 		return HWPersistence.aspectOf().getPm();
 	}
}
