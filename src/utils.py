import hashlib
import json
import pandas as pd
import numpy as np
import multiprocessing as mp

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