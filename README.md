# Slung load carrying with a multi-drone system

Code to acompany the ICRA 2025 submission "A Platform for Visual Pose Estimation in a Multi-Drone Slung Load System" - Harvey Merton and Ian W. Hunter. Data for this paper can be found in ws_ros2/src/slung_pose_measurement/data.

## Videos
- ICRA 2025 accompanying overview video: https://youtu.be/sau39pGFgZc
- Gazebo simulation: https://youtu.be/L-jx-SenBfA
- Real world flight: https://youtu.be/4FRBUPgz-X4
- Flight in testing apparatus: https://bit.ly/3Xrp9rz

## Installation
### Prerequisites
- Ubuntu 22.04
- ROS2 Humble

### Installation instructions
1. Install all prerequisites 
2. Clone the repository and all submodules to your home directory (~/) with:
```
git clone https://github.com/hmer101/multi_drone_slung_load_master.git --recurse-submodules
```
3. Build the PX4-Autopilot included as a submodule in this repository. For help with this, follow the instructions here: https://docs.px4.io/main/en/ros2/user_guide.html.
   - If you properly cloned this repo using '--recurse-submodules', you will not need to clone the PX4-Autopilot repository again; simply use the one provided in this repo.
   - You will have to run the ubuntu.sh setup script, install the MicroXRCEAgent, and make the px4 firmware with 'make px4_sitl gz_x500' (for simulation) and 'make px4_fmu-v6x_default' for hardware (all documented above).
   - Note that the PX4-Autopilot repo in this repository is a fork of the original with some minor tweaks. As such, using the original PX4-Autopilot repo in place of this fork will not work.
4. Install all python requirements with:
```
pip install -r requirements.txt
```
Note that colcon does not work with virtual environments so don't use one!

5. Make frame transforms .so. In the folder:

```
cd multi_drone_slung_load_master/ws_ros2/src/multi_drone_slung_load/multi_drone_slung_load/frame_transforms
```
make the frame_transforms object file:
```
mkdir -p build && \
cd build && \
cmake .. && \
make && \
cp frame_transforms.cpython-310-x86_64-linux-gnu.so ../../frame_transforms.so
```

6. Build the ros2 workspace by changing into the 'ws_ros2' directory and running:
  ```
  colcon build
```
7. Source the ros workspace (can add this to the .bashrc file) with:
```
  source /opt/ros/humble/setup.bash
  source ~/multi_drone_slung_load_master/ws_ros2/install/local_setup.bash 
```

A Docker container is coming soon. 

### Setup instructions
- Change configuration files in /ws_ros2/src/multi_drone_slung_load/config. Always rebuild and source before running.

## Running 
The system can either be run in simulation or outdoors.

### Simulation
1. Launch the simulated environment in a bash terminal with:
  ```
./ws_ros2/src/multi_drone_slung_load/tools/spawn_slung_sitl_gazebo.sh
```
2. Open a new bash terminal and run:
```
ros2 launch multi_drone_slung_load sim.launch.py
```

### Real world (outdoors)
The following section describes how to build the real-world system capable of outdoor flight.

> Running aerial drone experiments outdoors is dangerous; there are many variables that could make previously functioning code malfunction. Always simulate and test on the testing rig described below before attempting unconstrained flight. Ensure you comply with local drone flying regulations. The authors make no guarntees that the provided code will function as expected, and are not liable for any accidents that occur as a result of running this code.


### Building
**Multi-drone slung load system BOM**
| **Item**                                                             | **Cost (\$)** | **Quantity** | **Total cost (\$)** |
|----------------------------------------------------------------------|---------------|--------------|---------------------|
| **Drones**                                                           |               |              |                     |
| Holybro X500 v2 ARF kit                                             | 260.99        | 3            | 782.97              |
| Holybro Pixhawk 6x v3 set                                           | 317.99        | 4            | 1271.96             |
| Holybro H-RTK F9P GNSS - rover                                      | 296.99        | 4            | 1187.96             |
| Holybro power distribution board                                      | 8.59          | 4            | 34.36               |
| $14.8 \text{V}$ 4S $5500 \text{mAh}$ 70C LiPo battery            | 57.49         | 4            | 229.96              |
| Radiomaster R81 RC receiver                                         | 17.99         | 3            | 53.97               |
| SiK telemetry radio v3 - $915 \text{MHz}$ $100 \text{mW}$       | 58.99         | 4            | 235.96              |
| RJ45 Ethernet splitter 1 to 2 $100 \text{Mbps}$                   | 9.99          | 4            | 39.96               |
| Intel RealSense D435                                                | 297.13        | 3            | 891.39              |
| Realsense camera mounts - 3D printed                                 | 1.20          | 3            | 3.60                |
|                                                                    |               |              |                      |
| **Drones + load**                                                   |               |              |                     |
| Raspberry Pi (RPi) 5                                               | 80.00         | 4            | 320.00              |
| RPi 5 fans                                                          | 5.00          | 4            | 20.00               |
| MicroSD card $128 \text{Gb}$ class 10 200/90 mbs                 | 18.45         | 4            | 73.80               |
| UBEC SMPS $5 \text{V}$ / $6 \text{V}$, $5 \text{A}$ continuous    | 7.99          | 4            | 31.96               |
| 4-outlet, USB-powered Ethernet hub                                   | 31.99         | 1            | 31.99               |
| Ethernet cables - cat 6 $10 \text{Gbps}$ $1 \text{ft}$ 5pk       | 9.99          | 1            | 9.99                |
| Ethernet cables - cat 6 $10 \text{Gbps}$ $14 \text{ft}$          | 9.49          | 3            | 28.47               |
|                                                                    |               |              |                      |
| **Load**                                                            |               |              |                     |
| Kevlar rope with nylon sheathe - $8 \text{m}$                     | 39.99         | 1            | 39.99               |
| $2 \text{mm}$ Clear acrylic sheets - 2 pk                          | 31.99         | 1            | 31.99               |
| 6-pack tri-glide plastic buckles (3/4" combo set)                  | 9.59          | 1            | 9.59                |
| $100 \text{mm}$ bolts + nuts + washers + nylon spacers             | 125.39        | 1            | 125.39              |
|                                                                    |               |              |                      |
| **Auxiliary**                                                       |               |              |                     |
| Holybro H-RTK F9P RTK GNSS - base                                   | 325.99        | 1            | 325.99              |
| Radiomaster TX16S II RC                                            | 209.99        | 3            | 629.97              |
| TX16S battery $5000 \text{mAh}$ 2S $7.4 \text{V}$                | 24.99         | 3            | 74.97               |
|                                                                      |               | **Total**    | **\$ 6486.19**      |
*Bill of materials with approximate costs for the full multi-drone slung load system as at August 2024. All $ are in USD.*

**Testing apparatus BOM**
| **Item**                                                   | **Cost (\$)** | **Quantity** | **Total cost (\$)** |
|-----------------------------------------------------------|---------------|--------------|---------------------|
| 8020 aluminium t-slot profile extrusion: 30-3030          | 400.82        | 1            | 400.82              |
| Frame connecting plates                                     | 1.69          | 48           | 81.28               |
| 8020 frame angle pieces: 30-4332                          | 4.23          | 24           | 101.44              |
| 8020 t-nuts: 13024                                        | 2.30          | 180          | 414.00              |
| Cap screw, M6 × 1.00 mm, 15 mm long, 10pk                | 7.30          | 13           | 94.90               |
|                                                           |               |              |                     |
| 8020 40 to 40 series roller wheel: 40-2290               | 23.59         | 8            | 188.72              |
| Al rolling wheel holder - custom 3D print                 | 0.82          | 2            | 1.64                |
| 4" caster wheels - 4pk                                    | 25.99         | 1            | 25.99               |
|                                                           |               |              |                     |
| Dial a-distance retractable dog leash, 0--15 ft           | 34.99         | 2            | 69.98               |
| Rabbitgoo dog harness small                                | 19.98         | 1            | 19.98               |
| Leash holder - custom 3D print                             | 2.09          | 2            | 4.18                |
|                                                           |               | **Total**    | **\$ 1402.93**      |
*Bill of materials with approximate costs for the drone testing apparatus as at August 2024. All $ are in USD.*

#### Custom CAD
- Slung load: https://bit.ly/471B8il
- Testing apparatus frame: https://bit.ly/3z2u6gN
- On-drone camera mount: https://bit.ly/3T1c4SU
