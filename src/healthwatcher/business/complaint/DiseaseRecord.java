package healthwatcher.business.complaint;

import healthwatcher.data.IDiseaseRepository;
import healthwatcher.model.complaint.DiseaseType;
import lib.exceptions.ObjectNotFoundException;
import lib.util.IteratorDsk;



public class DiseaseRecord {

	private IDiseaseRepository diseaseRep;

	public DiseaseRecord(IDiseaseRepository repTipoDoenca) {
		this.diseaseRep = repTipoDoenca;
	}

	public DiseaseType search(int codigo) throws ObjectNotFoundException {
		return diseaseRep.search(codigo);
	}

	public IteratorDsk getDiseaseTypeList() throws ObjectNotFoundException {
		return diseaseRep.getDiseaseTypeList();
	}
}