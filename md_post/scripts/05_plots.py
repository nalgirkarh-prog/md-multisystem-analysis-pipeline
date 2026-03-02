import os
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

sns.set(style="whitegrid")

def load_xvg(path):
    data = []
    with open(path) as f:
        for line in f:
            if not line.startswith(("#", "@")):
                data.append([float(x) for x in line.split()])
    return pd.DataFrame(data)

def plot_system(system_path, system_name):
    print(f"Plotting system: {system_name}")

    # example RMSD
    rmsd_path = os.path.join(system_path, "rmsd", "rmsd.xvg")
    if os.path.exists(rmsd_path):
        df = load_xvg(rmsd_path)
        plt.figure()
        plt.plot(df[0], df[1])
        plt.xlabel("Time (ps)")
        plt.ylabel("RMSD (nm)")
        plt.tight_layout()
        os.makedirs("figures", exist_ok=True)
        plt.savefig(f"figures/{system_name}_rmsd.png")
        plt.close()

def main():
    outputs_root = "outputs"
    systems = [
        d for d in os.listdir(outputs_root)
        if os.path.isdir(os.path.join(outputs_root, d))
        and d != "statistics"
    ]

    for system in systems:
        system_path = os.path.join(outputs_root, system)
        plot_system(system_path, system)

    print("Multi-system plots generated successfully.")

if __name__ == "__main__":
    main()
