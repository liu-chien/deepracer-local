def reward_function(params):
    '''
    Example of rewarding the agent to stay inside two borders
    and penalizing getting too close to the objects in front
    '''

    import math

    # Read input variables
    waypoints = params['waypoints']
    closest_waypoints = params['closest_waypoints']
    heading = params['heading']
    all_wheels_on_track = params['all_wheels_on_track']
    distance_from_center = params['distance_from_center']
    track_width = params['track_width']
    progress = params['progress']
    steps = params['steps']

    norm_dist = min(distance_from_center/(track_width*0.5), 1.0)

    def cos_pi2(x):
        return math.cos(norm_dist*1.57079632679)

    def pow2(x):
        return -(x**2)+1

    def pow16_7(x):
        return -math.pow(abs(x), 2.285714) + 1
    
    def penalty():
        return float(progress*2.0)/max(float(steps), 1.0)

    def f(x):
        return pow16_7(x)

    reward = min(max(f(norm_dist)*penalty(), 0.0), 1.0) #clamp [0.0, 1.0]

    return reward

