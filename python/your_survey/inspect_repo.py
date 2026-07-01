from __future__ import annotations
import argparse
from collections import Counter
from lsst.daf.butler import Butler

p = argparse.ArgumentParser()
p.add_argument('--repo', required=True)
p.add_argument('--dataset-type', default='...')
p.add_argument('--collection', default=None)
p.add_argument('--limit', type=int, default=20)
args = p.parse_args()

butler = Butler(args.repo)
reg = butler.registry
print('Collections:')
for c in reg.queryCollections(): print(' -', c)
print('\nDataset types:')
for dt in reg.queryDatasetTypes(args.dataset_type): print(' -', dt.name, tuple(dt.dimensions.names), dt.storageClass_name)
kwargs = {'collections': args.collection} if args.collection else {}
counts = Counter(); shown = 0
print('\nDataset refs:')
for ref in reg.queryDatasets(args.dataset_type, **kwargs):
    counts[ref.datasetType.name] += 1
    if shown < args.limit:
        print(' -', ref.datasetType.name, dict(ref.dataId), ref.run)
        shown += 1
print('\nCounts:')
for k,v in counts.most_common(): print(' -', k, v)
