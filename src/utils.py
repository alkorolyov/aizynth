import hashlib
import json
import pandas as pd
import numpy as np
import multiprocessing as mp
from rdkit import Chem
from rdkit.Chem.MolStandardize.rdMolStandardize import SuperParent

def mol2smi(mol: Chem.Mol) -> str:
    return Chem.MolToSmiles(mol) if pd.notna(mol) else None

def smi2mol(smiles: str) -> Chem.Mol:
    return Chem.MolFromSmiles(smiles) if pd.notna(smiles) else None

def super_parent(mol: Chem.Mol) -> Chem.Mol | None:
    try:
        return SuperParent(mol)
    except:
        return None


def hash_dict(d: dict):
    return hashlib.sha256(json.dumps(d, sort_keys=True).encode('utf8')).hexdigest()

def _process_chunk(s: pd.Series, func, *args):
    return s.apply(func, args=args)

def apply_mp(s: pd.Series, func, *args, n_jobs: int = mp.cpu_count()):
    num_splits = min(len(s), n_jobs * 2)
    chunks = np.array_split(s, num_splits)
    with mp.Pool(processes=n_jobs) as pool:
        results = pool.starmap(_process_chunk, [(chunk, func, *args) for chunk in chunks])
    return pd.concat(results)