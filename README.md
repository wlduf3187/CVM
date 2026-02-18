# Lateral Dynamics Modeling of General n-unit Combination Vehicles: Symbolic Model Validation

## Project Overview
This repository contains a MATLAB script developed to verify the mathematical consistency between two different representations of a **Vehicle-Trailer System**. 

The primary objective is to prove that a high-dimensional augmented model (utilizing constraint augmentation) and a simplified state-space model are identical through **MATLAB Symbolic Math Toolbox**.

## Mathematical Context
The validation compares:
1.  **Augmented Formulation (proposed)**: A 5x5 system matrix representation ($M, D, F$) made by constraint augmentation
2.  **Conventional Formulation**: A 4x4 reduced-order model ($A_0, B_0$)

## Features
- **Symbolic Verification**: Uses MATLAB's `Symbolic Math Toolbox` to handle complex algebraic manipulations without numerical rounding errors.
- **Automated Equivalence Check**: Utilizes `isAlways` to perform a rigorous logical check that the difference between the two models is zero.
- **Coordinate Transformation**: Implements a transformation matrix $T_0$ to map state-space representations across different coordinate frames.

## Usage
1.  Ensure you have **MATLAB** and the **Symbolic Math Toolbox** installed.
2.  Clone this repository:
    ```bash
    git clone [https://github.com/wlduf3187/CVM.git](https://github.com/wlduf3187/CVM.git)
    ```
3.  Run the main script: `Symbolic_comparison_260219.m`.
4.  Check the Command Window for the validation result:
    - `Success: both models are identical.` (Expected)

## System Parameters
| Variable | Description |
| :--- | :--- |
| `m1, m2` | Mass of the vehicle(tractor) and trailer |
| `Izz1, Izz2` | Yaw moment of inertia for both units |
| `lf, lr` | Distance from Center of Gravity (CG) to the axles |
| `Cy1, Cy2, Cy3` | Cornering stiffness of the vehicle (front/rear) and trailer axles |
| `Vx` | Forward longitudinal velocity |
| `P` | Geometric offset of the hitch point from the vehicle's rear axle |


## Reference
This code is part of an ongoing research project. If you wish to reference this work before the formal publication, please cite this GitHub repository directly.

* **Status:** In preparation
* **Target Publication:** [Any Letters/Conferences on System Modeling and Control]
* **Note:** The full bibliographic information and the corresponding research paper will be updated here once the manuscript is officially published.

---
*Last Modified: 2026-02-19 by Jiyeol Oh*