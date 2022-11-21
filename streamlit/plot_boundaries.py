import streamlit as st
from sklearn.datasets import load_iris
from sklearn.neighbors import KNeighborsClassifier
from sklearn.decomposition import PCA
from sklearn.inspection import DecisionBoundaryDisplay
import matplotlib.pyplot as plt
import os

N_NEIGHBORS = st.slider(
    label="Wybierz liczbę najbliższych sąsiadów", min_value=1, max_value=49, step=2
)

X, y = load_iris(return_X_y=True)

pca = PCA(n_components=2)
pca.fit(X)
X = pca.transform(X)

plt.rcParams["font.family"] = "Inter"
plt.rcParams["figure.figsize"] = (6, 3)
plt.rcParams["image.cmap"] = "RdYlBu"

knn = KNeighborsClassifier(n_neighbors=N_NEIGHBORS)
knn.fit(X, y)

disp = DecisionBoundaryDisplay.from_estimator(knn, X, xlabel="PC1", ylabel="PC2")

disp.ax_.scatter(X[:, 0], X[:, 1], c=y, edgecolor="k")
plt.tight_layout()
plt.savefig("image", dpi=200)
image = st.image("image.png")
os.remove("image.png")
