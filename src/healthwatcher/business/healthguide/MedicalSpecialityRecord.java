package healthwatcher.business.healthguide;

import healthwatcher.data.ISpecialityRepository;
import lib.exceptions.ObjectNotFoundException;
import lib.util.IteratorDsk;

public class MedicalSpecialityRecord {

	private ISpecialityRepository repEspecialidade;

	public MedicalSpecialityRecord(ISpecialityRepository repEspecialidade) {
		this.repEspecialidade = repEspecialidade;
	}

	public IteratorDsk getListaEspecialidade() throws ObjectNotFoundException {
		return repEspecialidade.getSpecialityList();
	}
}
