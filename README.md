# Lateral Dynamics Modeling of General n-unit Combination Vehicles: Symbolic Model Validation

## Project Overview
By utilizing the proposed **Constraint Augmentation** method, the lateral dynamics model of a **general n-unit combination vehicle** can be derived in a highly intuitive and scalable manner. 

This repository provides a symbolic validation for the most common configuration: **a two-axle tractor + single-axle trailer system**. By comparing the *conventional representation* with the *proposed representation*, we demonstrate that both forms are mathematically identical and yield the same system response.

The primary objective is to prove that the proposed model (utilizing constraint augmentation) and the conventional state-space model are identical through **MATLAB Symbolic Math Toolbox**.

The validation compares:
1.  **Augmented Formulation (proposed)**: A 5x5 system matrix representation ($M, D, F$) made by constraint augmentation
2.  **Conventional Formulation**: A 4x4 reduced-order model ($A_0, B_0$)

## Model Description & Assumptions

### Key Assumptions
To maintain a linearized model suitable for control design (e.g., LQR, MPC), the following assumptions are applied:
* **Planar Motion:** Roll, pitch, and heave motions are neglected.
* **Single-Track Model:** The system is assumed to be symmetric about the longitudinal axis.
* **Constant Forward Speed:** The forward speed ($V_x$) is identical for all units and is assumed to be constant or slowly varying.
* **Linear Tire Region:** Small steering angles and small vehicle/tire slip angles are assumed.
* **Small Articulation Angles:** Small hitch angles are assumed, which is essential for the linearization of the kinematic constraints.

## System Parameters
| Variable | Description |
| :--- | :--- |
| `m1, m2` | Mass of the vehicle(tractor) and trailer |
| `Izz1, Izz2` | Yaw moment of inertia for both units |
| `lf, lr` | Distance from Center of Gravity (CG) to the axles |
| `Cy1, Cy2, Cy3` | Cornering stiffness of the vehicle (front/rear) and trailer axles |
| `Vx` | Forward longitudinal velocity |
| `P` | Geometric offset of the hitch point from the vehicle's rear axle |


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

## Reference
This code is part of an ongoing research project. If you wish to reference this work before the formal publication, please cite this GitHub repository directly.

* **Status:** In preparation
* **Target Publication:** [Any Letters/Conferences on System Modeling and Control]
* **Note:** The full bibliographic information and the corresponding research paper will be updated here once the manuscript is officially published.

---
*Last Modified: 2026-02-19 by Jiyeol Oh*