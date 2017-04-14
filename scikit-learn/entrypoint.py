#!/usr/bin/env python
# adapted from:
# https://github.com/scikit-learn/scikit-learn/blob/99530a3000cc123bcecfe5292cc5fc16eb419cd5/examples/classification/plot_classifier_comparison.py
# Code source: Gael Varoquaux
#              Andreas Muller
# Modified for documentation by Jaques Grobler
# License: BSD 3 clause

from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.datasets import make_moons, make_circles, make_classification
from sklearn.neighbors import KNeighborsClassifier
from sklearn.svm import SVC
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier, AdaBoostClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.discriminant_analysis import QuadraticDiscriminantAnalysis

import argparse
import time
import numpy as np
import warnings

warnings.filterwarnings("ignore", category=DeprecationWarning)

parser = argparse.ArgumentParser()
parser.add_argument('--num-samples', type=int, default=30000,
                    help='Num. of samples.')
parser.add_argument('--num-features', type=int, default=10,
                    help='Number of features.')
parser.add_argument('--num-classes', type=int, default=3,
                    help='Number of classes.')
parser.add_argument('--seed', type=int, default=1234,
                    help='Random generator seed.')
args = parser.parse_args()

n_samples = args.num_samples
n_features = args.num_features
n_classes = args.num_classes
seed = args.seed

h = .02  # step size in the mesh

names = ["Nearest_Neighbors", "Linear_SVM", "RBF_SVM", "Decision_Tree",
         "Random_Forest", "AdaBoost", "Naive_Bayes", "LDA", "QDA"]
classifiers = [
    KNeighborsClassifier(3),
    SVC(kernel="linear", C=0.025),
    SVC(gamma=2, C=1),
    DecisionTreeClassifier(max_depth=5),
    RandomForestClassifier(max_depth=5, n_estimators=10, max_features=1),
    AdaBoostClassifier(),
    GaussianNB(),
    LinearDiscriminantAnalysis(),
    QuadraticDiscriminantAnalysis()]

print("{")
tstart = time.time()
X, y = make_classification(n_samples=n_samples, n_features=n_features,
                           n_redundant=0, n_classes=n_classes, n_informative=2,
                           random_state=seed, n_clusters_per_class=1)
t = time.time() - tstart
print('  "generate_classification_data_time": {:f},'.format(t))
rng = np.random.RandomState(2)
X += 2 * rng.uniform(size=X.shape)
ds_linearly_separable = (X, y)


tstart = time.time()
ds_moons = make_moons(n_samples=n_samples, noise=0.3, random_state=0)
t = time.time() - tstart
print('  "generate_moons_data_time": {:f},'.format(t))
tstart = time.time()
ds_circles = make_circles(n_samples=n_samples, noise=0.2, factor=0.5,
                          random_state=1)
t = time.time() - tstart
print('  "generate_circles_data_time": {:f},'.format(t))

datasets = [ds_moons, ds_circles, ds_linearly_separable]
ds_names = ['moons', 'circles', 'classification']

i = 1
# iterate over datasets
for ds_cnt, ds in enumerate(datasets):
    # preprocess dataset, split into training and test part
    X, y = ds
    X = StandardScaler().fit_transform(X)
    X_train, X_test, y_train, y_test = \
        train_test_split(X, y, test_size=.4, random_state=42)

    x_min, x_max = X[:, 0].min() - .5, X[:, 0].max() + .5
    y_min, y_max = X[:, 1].min() - .5, X[:, 1].max() + .5
    xx, yy = np.meshgrid(np.arange(x_min, x_max, h),
                         np.arange(y_min, y_max, h))

    i += 1

    # iterate over classifiers
    for name, clf in zip(names, classifiers):
        tstart = time.time()
        clf.fit(X_train, y_train)
        t = time.time() - tstart
        score = clf.score(X_test, y_test)
        print('  "{}_{}_time": {:f},'.format(name, ds_names[ds_cnt], t))
        print('  "{}_{}_score": {:f}'.format(name, ds_names[ds_cnt], score))
        if ds_cnt != 2 or name != 'QDA':
            print(',')

        i += 1

print("}")
