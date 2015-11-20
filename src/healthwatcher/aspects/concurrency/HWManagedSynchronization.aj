package healthwatcher.aspects.concurrency;

import healthwatcher.business.employee.EmployeeRecord;
import healthwatcher.model.employee.Employee;
import lib.concurrency.ConcurrencyManager;

/**
 * This aspect synchronizes a method from employee record using a concurrency manager
 */
public aspect HWManagedSynchronization {

	private ConcurrencyManager manager = new ConcurrencyManager();
	
	public pointcut synchronizationPoints(Employee employee) :
		execution(* EmployeeRecord.insert(Employee)) && args(employee);
	
	before(Employee employee) : synchronizationPoints(employee) {
		manager.beginExecution(employee.getLogin());
	}
	
	before(Employee employee) : synchronizationPoints(employee) {
		manager.endExecution(employee.getLogin());
	}
}
