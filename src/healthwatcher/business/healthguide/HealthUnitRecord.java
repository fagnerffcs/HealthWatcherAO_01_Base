package healthwatcher.business.healthguide;

import healthwatcher.data.IHealthUnitRepository;
import healthwatcher.model.healthguide.HealthUnit;
import lib.exceptions.ObjectNotFoundException;
import lib.exceptions.ObjectNotValidException;
import lib.util.ConcreteIterator;
import lib.util.IteratorDsk;

public class HealthUnitRecord {

	private IHealthUnitRepository healthUnitRep;

	public HealthUnitRecord(IHealthUnitRepository repUnidadeSaude) {
		this.healthUnitRep = repUnidadeSaude;
	}

	public void update(HealthUnit unit) throws ObjectNotFoundException,
			ObjectNotValidException {
		healthUnitRep.update(unit);
	}

	public IteratorDsk searchSpecialityByHealthUnit(int code) throws ObjectNotFoundException {
		HealthUnit us = healthUnitRep.search(code);
		return new ConcreteIterator(us.getSpecialities());
	}

	public IteratorDsk searchHealthUnitsBySpeciality(int code) throws ObjectNotFoundException {
		return healthUnitRep.getHealthUnitListBySpeciality(code);
	}

	public IteratorDsk getHealthUnitList() throws ObjectNotFoundException {
		return healthUnitRep.getHealthUnitList();
	}

	public IteratorDsk getPartialHealthUnitList() throws ObjectNotFoundException {
		return healthUnitRep.getPartialHealthUnitList();
	}

	public HealthUnit search(int healthUnitCode) throws ObjectNotFoundException {
		return healthUnitRep.search(healthUnitCode);
	}
}