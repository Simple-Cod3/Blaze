//
//  GlossaryTerms.swift
//  Blaze
//
//  Created by Nathan Choi on 9/5/20.
//

import Foundation

struct Term: Identifiable, Comparable {
    static func < (lhs: Term, rhs: Term) -> Bool {
        return lhs.id < rhs.id
    }
    
    var id: String
    var definition: String
}


/// Data parsed with:
/* javascript
 
 console.clear()
 alphabet = "abcdefghijklmnopqrstuvwxyz".toUpperCase().split("")
 output = "[\n"
 for (const l of alphabet) {
     output += `\t"${l.toLowerCase()}" : [`
     $(`.tabbertab[title=${l}] > p:not([style])`).each(function() {
         let id = $(this).children().first().text();
         var def = $(this).clone().children().remove().end().text() + ""
         def = def.trim().replaceAll("\n", "")
         def = def.replaceAll("    ", "").replaceAll('"', '\\"')
         console.log(def)
         output += `\n\t\tTerm(id: "${id}", definition: "${def}"),`;
     });
     output += "\n\t],\n"
 }
 output += "]"
 
 */

struct GlossaryDatabase {
    static var terms: [String: [Term]] = [
        "a" : [
            Term(id: "Aerial Fuels", definition: "All live and dead vegetation in the forest canopy or above surface fuels,including tree branches, twigs and cones, snags, moss, and high brush."),
            Term(id: "Aerial Ignition", definition: "Ignition of fuels by dropping incendiary devices or materials from aircraft."),
            Term(id: "Air Tanker", definition: "A fixed-wing aircraft equipped to drop fire retardants or suppressants."),
            Term(id: "Agency", definition: "Any federal, state, or county government organization participating with jurisdictionalresponsibilities."),
            Term(id: "Anchor Point", definition: "An advantageous location, usually a barrier to fire spread, from which tostart building a fire line. An anchor point is used to reduce the chance offirefighters being flanked by fire."),
            Term(id: "Aramid", definition: "The generic name for a high-strength, flame-resistant synthetic fabric usedin the shirts and jeans of firefighters. Nomex, a brand name for aramid fabric,is the term commonly used by firefighters."),
            Term(id: "Aspect", definition: "Direction toward which a slope faces."),
        ],
        "b" : [
            Term(id: "Backfire", definition: "A fire set along the inner edge of a fireline to consume the fuel in the pathof a wildfire and/or change the direction of force of the fire's convectioncolumn."),
            Term(id: "Backpack Pump", definition: "A portable sprayer with hand-pump, fed from a liquid-filled container fittedwith straps, used mainly in fire and pest control. (See also Bladder Bag.)"),
            Term(id: "Bambi Bucket", definition: "A collapsible bucket slung below a helicopter. Used to dip water from a varietyof sources for fire suppression."),
            Term(id: "Behave", definition: "A system of interactive computer programs for modeling fuel and fire behaviorthat consists of two systems: BURN and FUEL."),
            Term(id: "Bladder Bag", definition: "A collapsible backpack portable sprayer made of neoprene or high-strengthnylon fabric fitted with a pump. (See also Backpack Pump.)"),
            Term(id: "Blow-up:", definition: "A sudden increase in fire intensity or rate ofspread strong enough to prevent direct control or to upset control plans.Blow-ups are often accompanied by violent convection and may have other characteristicsof a fire storm. (See Flare-up.)"),
            Term(id: "Brush", definition: "A collective term that refers to stands of vegetation dominated by shrubby,woody plants, or low growing trees, usually of a type undesirable for livestockor timber management."),
            Term(id: "Brush Fire", definition: "A fire burning in vegetation that is predominantly shrubs, brush and scrubgrowth."),
            Term(id: "Bucket Drops", definition: "The dropping of fire retardants or suppressants from specially designed bucketsslung below a helicopter."),
            Term(id: "Buffer Zones", definition: "An area of reduced vegetation that separates wildlands from vulnerable residentialor business developments. This barrier is similar to a greenbelt in that itis usually used for another purpose such as agriculture, recreation areas,parks, or golf courses."),
            Term(id: "Bump-up Method", definition: "A progressive method of building a fire line on a wildfire without changingrelative positions in the line. Work is begun with a suitable space betweenworkers. Whenever one worker overtakes another, all workers ahead move onespace forward and resume work on the uncompleted part of the line. The lastworker does not move ahead until completing his or her space."),
            Term(id: "Burn Out", definition: "Setting fire inside a control line to widen it or consume fuel between theedge of the fire and the control line."),
            Term(id: "Burning Ban", definition: "A declared ban on open air burning within a specified area, usually due tosustained high fire danger."),
            Term(id: "Burning Conditions", definition: "The state of the combined factors of the environment that affect fire behaviorin a specified fuel type."),
            Term(id: "Burning Index", definition: "An estimate of the potential difficulty of fire containment as it relatesto the flame length at the most rapidly spreading portion of a fire's perimeter."),
            Term(id: "Burning Period", definition: "That part of each 24-hour period when fires spread most rapidly, typicallyfrom 10:00 a.m. to sundown."),
        ],
        "c" : [
            Term(id: "Campfire", definition: "As used to classify the cause of a wildland fire, a fire that was startedfor cooking or warming that spreads sufficiently from its source to requireaction by a fire control agency."),
            Term(id: "Candle or Candling", definition: "A single tree or a very small clump of trees which is burning from the bottomup."),
            Term(id: "Chain", definition: "A unit of linear measurement equal to 66 feet."),
            Term(id: "Closure", definition: "Legal restriction, but not necessarily elimination of specified activitiessuch as smoking, camping, or entry that might cause fires in a given area."),
            Term(id: "Cold Front", definition: "The leading edge of a relatively cold air mass that displaces warmer air.The heavier cold air may cause some of the warm air to be lifted. If the liftedair contains enough moisture, the result may be cloudiness, precipitation,and thunderstorms. If both air masses are dry, no clouds may form. Followingthe passage of a cold front in the Northern Hemisphere, westerly or northwesterlywinds of 15 to 30 or more miles per hour often continue for 12 to 24 hours."),
            Term(id: "Cold Trailing", definition: "A method of controlling a partly dead fire edge by carefully inspecting andfeeling with the hand for heat to detect any fire, digging out every livespot, and trenching any live edge."),
            Term(id: "Command Staff", definition: "The command staff consists of the information officer, safety officer andliaison officer. They report directly to the incident commander and may haveassistants."),
            Term(id: "Complex", definition: "Two or more individual incidents located in the same general area which areassigned to a single incident commander or unified command."),
            Term(id: "Contain a fire", definition: "A fuel break around the fire has been completed. This break may include naturalbarriers or manually and/or mechanically constructed line."),
            Term(id: "Control a fire", definition: "The complete extinguishment of a fire, including spot fires. Fireline hasbeen strengthened so that flare-ups from within the perimeter of the firewill not break through this line."),
            Term(id: "Control Line", definition: "All built or natural fire barriers and treated fire edge used to control afire."),
            Term(id: "Cooperating Agency", definition: "An agency supplying assistance other than direct suppression, rescue, support,or service functions to the incident control effort; e.g., Red Cross, lawenforcement agency, telephone company, etc."),
            Term(id: "Coyote Tactics", definition: "A progressive line construction duty involving self-sufficient crews thatbuild fire line until the end of the operational period, remain at or nearthe point while off duty, and begin building fire line again the next operationalperiod where they left off."),
            Term(id: "Creeping Fire", definition: "Fire burning with a low flame and spreading slowly."),
            Term(id: "Crew Boss", definition: "A person in supervisory charge of usually 16 to 21 firefighters and responsiblefor their performance, safety, and welfare."),
            Term(id: "Crown Fire (Crowning)", definition: "The movement of fire through the crowns of trees or shrubs more or less independentlyof the surface fire."),
            Term(id: "Curing", definition: "Drying and browning of herbaceous vegetation or slash."),
        ],
        "d" : [
            Term(id: "Dead Fuels", definition: "Fuels with no living tissue in which moisture content is governed almost entirelyby atmospheric moisture (relative humidity and precipitation), dry-bulb temperature,and solar radiation."),
            Term(id: "Debris Burning", definition: "A fire spreading from any fire originally set for the purpose of clearingland or for rubbish, garbage, range, stubble, or meadow burning."),
            Term(id: "Defensible Space", definition: "An area either natural or manmade where material capable of causing a fireto spread has been treated, cleared, reduced, or changed to act as a barrierbetween an advancing wildland fire and the loss to life, property, or resources.In practice, \"defensible space\" is defined as an area a minimumof 30 feet around a structure that is cleared of flammable brush or vegetation."),
            Term(id: "Deployment", definition: "See Fire Shelter Deployment."),
            Term(id: "Detection", definition: "The act or system of discovering and locating fires."),
            Term(id: "Direct Attack", definition: "Any treatment of burning fuel, such as by wetting, smothering, or chemicallyquenching the fire or by physically separating burning from unburned fuel."),
            Term(id: "Dispatch", definition: "The implementation of a command decision to move a resource or resources fromone place to another."),
            Term(id: "Dispatcher", definition: "A person employed who receives reports of discovery and status of fires, confirmstheir locations, takes action promptly to provide people and equipment likelyto be needed for control in first attack, and sends them to the proper place."),
            Term(id: "Dispatch Center", definition: "A facility from which resources are directly assigned to an incident."),
            Term(id: "Division", definition: "Divisions are used to divide an incident into geographical areas of operation.Divisions are established when the number of resources exceeds the span-of-controlof the operations chief. A division is located with the Incident Command Systemorganization between the branch and the task force/strike team."),
            Term(id: "Dozer", definition: "Any tracked vehicle with a front-mounted blade used for exposing mineral soil."),
            Term(id: "Dozer Line", definition: "Fire line constructed by the front blade of a dozer."),
            Term(id: "Drip Torch", definition: "Hand-held device for igniting fires by dripping flaming liquid fuel on thematerials to be burned; consists of a fuel fount, burner arm, and igniter.Fuel used is generally a mixture of diesel and gasoline."),
            Term(id: "Drop Zone", definition: "Target area for air tankers, helitankers, and cargo dropping."),
            Term(id: "Drought Index", definition: "A number representing net effect of evaporation, transpiration, and precipitationin producing cumulative moisture depletion in deep duff or upper soil layers."),
            Term(id: "Dry Lightning Storm", definition: "Thunderstorm in which negligible precipitation reaches the ground. Also calleda dry storm."),
            Term(id: "Duff", definition: "The layer of decomposing organic materials lying below the litter layer offreshly fallen twigs, needles, and leaves and immediately above the mineralsoil."),
        ],
        "e" : [
            Term(id: "Energy Release Component (ERC)", definition: "The computed total heat released per unit area (British thermal units persquare foot) within the fire front at the head of a moving fire."),
            Term(id: "Engine", definition: "Any ground vehicle providing specified levels of pumping, water and hose capacity."),
            Term(id: "Engine Crew", definition: "Firefighters assigned to an engine. The Fireline Handbook defines the minimumcrew makeup by engine type."),
            Term(id: "Entrapment", definition: "A situation where personnel are unexpectedly caught in a fire behavior-related,life-threatening position where planned escape routes or safety zones areabsent, inadequate, or compromised. An entrapment may or may not include deploymentof a fire shelter for its intended purpose. These situations may or may notresult in injury. They include \"near misses.\""),
            Term(id: "Environmental Assessment (EA)", definition: "EAs were authorized by the National Environmental Policy Act (NEPA) of 1969.They are concise, analytical documents prepared with public participationthat determine if an Environmental Impact Statement (EIS) is needed for aparticular project or action. If an EA determines an EIS is not needed, theEA becomes the document allowing agency compliance with NEPA requirements."),
            Term(id: "Environmental Impact Statement (EIS)", definition: "EISs were authorized by the National Environmental Policy Act (NEPA) of 1969.Prepared with public participation, they assist decision makers by providinginformation, analysis and an array of action alternatives, allowing managersto see the probable effects of decisions on the environment. Generally, EISsare written for large-scale actions or geographical areas."),
            Term(id: "Equilibrium Moisture Content", definition: "Moisture content that a fuel particle will attain if exposed for an infiniteperiod in an environment of specified constant temperature and humidity. Whena fuel particle reaches equilibrium moisture content, net exchange of moisturebetween it and the environment is zero."),
            Term(id: "Escape Route:", definition: "A preplanned and understood route firefighterstake to move to a safety zone or other low-risk area, such as an already burnedarea, previously constructed safety area, a meadow that won't burn, naturalrocky area that is large enough to take refuge without being burned. Whenescape routes deviate from a defined physical path, they should be clearlymarked (flagged)."),
            Term(id: "Escaped Fire", definition: "A fire which has exceeded or is expected to exceed initial attack capabilitiesor prescription."),
            Term(id: "Extended Attack Incident", definition: "A wildland fire that has not been contained or controlled by initial attackforces and for which more firefighting resources are arriving, en route, orbeing ordered by the initial attack incident commander."),
            Term(id: "Extreme Fire Behavior", definition: "\"Extreme\" implies a level of fire behavior characteristics thatordinarily precludes methods of direct control action. One of more of thefollowing is usually involved: high rate of spread, prolific crowning and/orspotting, presence of fire whirls, strong convection column. Predictabilityis difficult because such fires often exercise some degree of influence ontheir environment and behave erratically, sometimes dangerously."),
        ],
        "f" : [
            Term(id: "Faller", definition: "A person who fells trees. Also called a sawyer or cutter."),
            Term(id: "Field Observer", definition: "Person responsible to the Situation Unit Leader for collecting and reportinginformation about an incident obtained from personal observations and interviews."),
            Term(id: "Fine (Light) Fuels", definition: "Fast-drying fuels, generally with a comparatively high surface area-to-volumeratio, which are less than 1/4-inch in diameter and have a timelag of onehour or less. These fuels readily ignite and are rapidly consumed by firewhen dry."),
            Term(id: "Fingers of a Fire", definition: "The long narrow extensions of a fire projecting from the main body."),
            Term(id: "Fire Behavior", definition: "The manner in which a fire reacts to the influences of fuel, weather and topography."),
            Term(id: "Fire Behavior Forecast", definition: "Prediction of probable fire behavior, usually prepared by a Fire BehaviorOfficer, in support of fire suppression or prescribed burning operations."),
            Term(id: "Fire Behavior Specialist", definition: "A person responsible to the Planning Section Chief for establishing a weatherdata collection system and for developing fire behavior predictions basedon fire history, fuel, weather and topography."),
            Term(id: "Fire Break", definition: "A natural or constructed barrier used to stop or check fires that may occur,or to provide a control line from which to work."),
            Term(id: "Fire Cache", definition: "A supply of fire tools and equipment assembled in planned quantities or standardunits at a strategic point for exclusive use in fire suppression."),
            Term(id: "Fire Crew", definition: "An organized group of firefighters under the leadership of a crew leader orother designated official."),
            Term(id: "Fire Front", definition: "The part of a fire within which continuous flaming combustion is taking place.Unless otherwise specified the fire front is assumed to be the leading edgeof the fire perimeter. In ground fires, the fire front may be mainly smolderingcombustion."),
            Term(id: "Fire Intensity", definition: "A general term relating to the heat energy released by a fire."),
            Term(id: "Fire Line", definition: "A linear fire barrier that is scraped or dug to mineral soil."),
            Term(id: "Fire Load", definition: "The number and size of fires historically experienced on a specified unitover a specified period (usually one day) at a specified index of fire danger."),
            Term(id: "Fire Management Plan (FMP)", definition: "A strategic plan that defines a program to manage wildland and prescribedfires and documents the Fire Management Program in the approved land use plan.The plan is supplemented by operational plans such as preparedness plans,preplanned dispatch plans, prescribed fire plans, and prevention plans."),
            Term(id: "Fire Perimeter", definition: "The entire outer edge or boundary of a fire."),
            Term(id: "Fire Season:", definition: "1) Period(s) of the year during which wildlandfires are likely to occur, spread, and affect resource values sufficient towarrant organized fire management activities. 2) A legally enacted time duringwhich burning activities are regulated by state or local authority."),
            Term(id: "Fire Shelter", definition: "An aluminized tent offering protection by means of reflecting radiant heatand providing a volume of breathable air in a fire entrapment situation. Fireshelters should only be used in life-threatening situations, as a last resort."),
            Term(id: "Fire Shelter Deployment", definition: "The removing of a fire shelter from its case and using it as protection againstfire."),
            Term(id: "Fire Storm", definition: "Violent convection caused by a large continuous area of intense fire. Oftencharacterized by destructively violent surface indrafts, near and beyond theperimeter, and sometimes by tornado-like whirls."),
            Term(id: "Fire Triangle", definition: "Instructional aid in which the sides of a triangle are used to represent thethree factors (oxygen, heat, fuel) necessary for combustion and flame production;removal of any of the three factors causes flame production to cease."),
            Term(id: "Fire Use Module (Prescribed Fire Module)", definition: "A team of skilled and mobile personnel dedicated primarily to prescribed firemanagement. These are national and interagency resources, available throughoutthe prescribed fire season, that can ignite, hold and monitor prescribed fires."),
            Term(id: "Fire Weather", definition: "Weather conditions that influence fire ignition, behavior and suppression."),
            Term(id: "Fire Weather Watch", definition: "A term used by fire weather forecasters to notify using agencies, usually24 to 72 hours ahead of the event, that current and developing meteorologicalconditions may evolve into dangerous fire weather."),
            Term(id: "Fire Whirl", definition: "Spinning vortex column of ascending hot air and gases rising from a fire andcarrying aloft smoke, debris, and flame. Fire whirls range in size from lessthan one foot to more than 500 feet in diameter. Large fire whirls have theintensity of a small tornado."),
            Term(id: "Firefighting Resources", definition: "All people and major items of equipment that can or potentially could be assignedto fires."),
            Term(id: "Flame Height", definition: "The average maximum vertical extension of flames at the leading edge of thefire front. Occasional flashes that rise above the general level of flamesare not considered. This distance is less than the flame length if flamesare tilted due to wind or slope."),
            Term(id: "Flame Length", definition: "The distance between the flame tip and the midpoint of the flame depth atthe base of the flame (generally the ground surface); an indicator of fireintensity."),
            Term(id: "Flaming Front", definition: "The zone of a moving fire where the combustion is primarily flaming. Behindthis flaming zone combustion is primarily glowing. Light fuels typically havea shallow flaming front, whereas heavy fuels have a deeper front. Also calledfire front."),
            Term(id: "Flanks of a Fire", definition: "The parts of a fire's perimeter that are roughly parallel to the main directionof spread."),
            Term(id: "Flare-up", definition: "Any sudden acceleration of fire spread or intensification of a fire. Unlikea blow-up, a flare-up lasts a relatively short time and does not radicallychange control plans."),
            Term(id: "Flash Fuels", definition: "Fuels such as grass, leaves, draped pine needles, fern, tree moss and somekinds of slash, that ignite readily and are consumed rapidly when dry. Alsocalled fine fuels."),
            Term(id: "Forb", definition: "A plant with a soft, rather than permanent woody stem, that is not a grassor grass-like plant."),
            Term(id: "Fuel", definition: "Combustible material. Includes, vegetation, such as grass, leaves, groundlitter, plants, shrubs and trees, that feed a fire. (See Surface Fuels.)"),
            Term(id: "Fuel Bed", definition: "An array of fuels usually constructed with specific loading, depth and particlesize to meet experimental requirements; also, commonly used to describe thefuel composition in natural settings."),
            Term(id: "Fuel Loading", definition: "The amount of fuel present expressed quantitatively in terms of weight offuel per unit area."),
            Term(id: "Fuel Model", definition: "Simulated fuel complex (or combination of vegetation types) for which allfuel descriptors required for the solution of a mathematical rate of spreadmodel have been specified."),
            Term(id: "Fuel Moisture (Fuel Moisture Content)", definition: "The quantity of moisture in fuel expressed as a percentage of the weight whenthoroughly dried at 212 degrees Fahrenheit."),
            Term(id: "Fuel Reduction:", definition: "Manipulation, including combustion, or removalof fuels to reduce the likelihood of ignition and/or to lessen potential damageand resistance to control."),
            Term(id: "Fuel Type", definition: "An identifiable association of fuel elements of a distinctive plant species,form, size, arrangement, or other characteristics that will cause a predictablerate of fire spread or difficulty of control under specified weather conditions."),
            Term(id: "Fusee", definition: "A colored flare designed as a railway warning device and widely used to ignitesuppression and prescription fires."),
        ],
        "g" : [
            Term(id: "General Staff", definition: "The group of incident management personnel reporting to the incident commander.They may each have a deputy, as needed. Staff consists of operations sectionchief, planning section chief, logistics section chief, and finance/administrationsection chief."),
            Term(id: "Geographic Area", definition: "A political boundary designated by the wildland fire protection agencies,where these agencies work together in the coordination and effective utilization"),
            Term(id: "Ground Fuel", definition: "All combustible materials below the surface litter, including duff, tree orshrub roots, punchy wood, peat, and sawdust, that normally support a glowingcombustion without flame."),
        ],
        "h" : [
            Term(id: "Haines Index", definition: "An atmospheric index used to indicate the potential for wildfire growth bymeasuring the stability and dryness of the air over a fire."),
            Term(id: "Hand Line", definition: "A fireline built with hand tools."),
            Term(id: "Hazard Reduction", definition: "Any treatment of a hazard that reduces the threat of ignition and fire intensityor rate of spread."),
            Term(id: "Head of a Fire", definition: "The side of the fire having the fastest rate of spread."),
            Term(id: "Heavy Fuels", definition: "Fuels of large diameter such as snags, logs, large limb wood, that igniteand are consumed more slowly than flash fuels."),
            Term(id: "Helibase", definition: "The main location within the general incident area for parking, fueling, maintaining,and loading helicopters. The helibase is usually located at or near the incidentbase."),
            Term(id: "Helispot", definition: "A temporary landing spot for helicopters."),
            Term(id: "Helitack", definition: "The use of helicopters to transport crews, equipment, and fire retardantsor suppressants to the fire line during the initial stages of a fire."),
            Term(id: "Helitack Crew", definition: "A group of firefighters trained in the technical and logistical use of helicoptersfor fire suppression."),
            Term(id: "Holding Actions", definition: "Planned actions required to achieve wildland prescribed fire management objectives.These actions have specific implementation timeframes for fire use actionsbut can have less sensitive implementation demands for suppression actions."),
            Term(id: "Holding Resources", definition: "Firefighting personnel and equipment assigned to do all required fire suppressionwork following fireline construction but generally not including extensivemop-up."),
            Term(id: "Hose Lay", definition: "Arrangement of connected lengths of fire hose and accessories on the ground,beginning at the first pumping unit and ending at the point of water delivery."),
            Term(id: "Hotshot Crew", definition: "A highly trained fire crew used mainly to build fireline by hand."),
            Term(id: "Hotspot", definition: "A particular active part of a fire."),
            Term(id: "Hotspotting", definition: "Reducing or stopping the spread of fire at points of particularly rapid rateof spread or special threat, generally the first step in prompt control, withemphasis on first priorities."),
        ],
        "i" : [
            Term(id: "Incident", definition: "A human-caused or natural occurrence, such as wildland fire, that requiresemergency service action to prevent or reduce the loss of life or damage toproperty or natural resources."),
            Term(id: "Incident Action Plan (IAP)", definition: "Contains objectives reflecting the overall incident strategy and specifictactical actions and supporting information for the next operational period.The plan may be oral or written. When written, the plan may have a numberof attachments, including: incident objectives, organization assignment list,division assignment, incident radio communication plan, medical plan, trafficplan, safety plan, and incident map."),
            Term(id: "Incident Command Post (ICP)", definition: "Location at which primary command functions are executed. The ICP may be co-locatedwith the incident base or other incident facilities."),
            Term(id: "Incident Command System (ICS)", definition: "The combination of facilities, equipment, personnel, procedure and communicationsoperating within a common organizational structure, with responsibility forthe management of assigned resources to effectively accomplish stated objectivespertaining to an incident."),
            Term(id: "Incident Commander", definition: "Individual responsible for the management of all incident operations at theincident site."),
            Term(id: "Incident Management Team", definition: "The incident commander and appropriate general or command staff personnelassigned to manage an incident."),
            Term(id: "Incident Objectives", definition: "Statements of guidance and direction necessary for selection of appropriatestrategy(ies), and the tactical direction of resources. Incident objectivesare based on realistic expectations of what can be accomplished when all allocatedresources have been effectively deployed."),
            Term(id: "Infrared Detection", definition: "The use of heat sensing equipment, known as Infrared Scanners, for detectionof heat sources that are not visually detectable by the normal surveillancemethods of either ground or air patrols."),
            Term(id: "Initial Attack", definition: "The actions taken by the first resources to arrive at a wildfire to protectlives and property, and prevent further extension of the fire."),
        ],
        "j" : [
            Term(id: "Job Hazard Analysis", definition: "This analysis of a project is completed by staff to identify hazards to employeesand the public. It identifies hazards, corrective actions and the requiredsafety equipment to ensure public and employee safety."),
            Term(id: "Jump Spot", definition: "Selected landing area for smokejumpers."),
            Term(id: "Jump Suit", definition: "Approved protection suite work by smokejumpers."),
        ],
        "k" : [
            Term(id: "Keech Byram Drought Index (KBDI):", definition: "Commonly-used droughtindex adapted for fire management applications, with a numerical range from0 (no moisture deficiency) to 800 (maximum drought)."),
            Term(id: "Knock Down", definition: "To reduce the flame or heat on the more vigorously burning parts of a fireedge."),
        ],
        "l" : [
            Term(id: "Ladder Fuels", definition: "Fuels which provide vertical continuity between strata, thereby allowing fireto carry from surface fuels into the crowns of trees or shrubs with relativeease. They help initiate and assure the continuation of crowning."),
            Term(id: "Large Fire", definition: "1) For statistical purposes, a fire burning more than a specified area ofland e.g., 300 acres. 2) A fire burning with a size and intensity such thatits behavior is determined by interaction between its own convection columnand weather conditions above the surface."),
            Term(id: "Lead Plane", definition: "Aircraft with pilot used to make dry runs over the target area to check wingand smoke conditions and topography and to lead air tankers to targets andsupervise their drops."),
            Term(id: "Light (Fine) Fuels", definition: "Fast-drying fuels, generally with a comparatively high surface area-to-volumeratio, which are less than 1/4-inch in diameter and have a timelag of onehour or less. These fuels readily ignite and are rapidly consumed by firewhen dry."),
            Term(id: "Lightning Activity Level (LAL)", definition: "A number, on a scale of 1 to 6, that reflects frequency and character of cloud-to-groundlightning. The scale is exponential, based on powers of 2 (i.e., LAL 3 indicatestwice the lightning of LAL 2)."),
            Term(id: "Line Scout", definition: "A firefighter who determines the location of a fire line."),
            Term(id: "Litter", definition: "Top layer of the forest, scrubland, or grassland floor, directly above thefermentation layer, composed of loose debris of dead sticks, branches, twigs,and recently fallen leaves or needles, little altered in structure by decomposition."),
            Term(id: "Live Fuels", definition: "Living plants, such as trees, grasses, and shrubs, in which the seasonal moisturecontent cycle is controlled largely by internal physiological mechanisms,rather than by external weather influences."),
        ],
        "m" : [
            Term(id: "Micro-Remote Environmental Monitoring System (Micro-REMS)", definition: "Mobile weather monitoring station. A Micro-REMS usually accompanies an incidentmeteorologist and ATMU to an incident."),
            Term(id: "Mineral Soil", definition: "Soil layers below the predominantly organic horizons; soil with little combustiblematerial."),
            Term(id: "Mobilization", definition: "The process and procedures used by all organizations, federal, state and localfor activating, assembling, and transporting all resources that have beenrequested to respond to or support an incident."),
            Term(id: "Modular Airborne Firefighting System (MAFFS)", definition: "A manufactured unit consisting of five interconnecting tanks, a control pallet,and a nozzle pallet, with a capacity of 3,000 gallons, designed to be rapidlymounted inside an unmodified C-130 (Hercules) cargo aircraft for use in droppingretardant on wildland fires."),
            Term(id: "Mop-up", definition: "To make a fire safe or reduce residual smoke after the fire has been controlledby extinguishing or removing burning material along or near the control line,felling snags, or moving logs so they won't roll downhill."),
            Term(id: "Multi-Agency Coordination (MAC)", definition: "A generalized term which describes the functions and activities of representativesof involved agencies and/or jurisdictions who come together to make decisionsregarding the prioritizing of incidents, and the sharing and use of criticalresources. The MAC organization is not a part of the on-scene ICS and is notinvolved in developing incident strategy or tactics."),
            Term(id: "Mutual Aid Agreement", definition: "Written agreement between agencies and/or jurisdictions in which they agreeto assist one another upon request, by furnishing personnel and equipment."),
        ],
        "n" : [
            Term(id: "National Environmental Policy Act (NEPA)", definition: "NEPA is the basic national law for protection of the environment, passed byCongress in 1969. It sets policy and procedures for environmental protection,and authorizes Environmental Impact Statements and Environmental Assessmentsto be used as analytical tools to help federal managers make decisions."),
            Term(id: "National Fire Danger Rating System (NFDRS)", definition: "A uniform fire danger rating system that focuses on the environmental factorsthat control the moisture content of fuels."),
            Term(id: "National Wildfire Coordinating Group", definition: "A group formed under the direction of the Secretaries of Agriculture and theInterior and comprised of representatives of the U.S. Forest Service, Bureauof Land Management, Bureau of Indian Affairs, National Park Service, U.S.Fish and Wildlife Service and Association of State Foresters. The group'spurpose is to facilitate coordination and effectiveness of wildland fire activitiesand provide a forum to discuss, recommend action, or resolve issues and problemsof substantive nature. NWCG is the certifying body for all courses in theNational Fire Curriculum."),
            Term(id: "Nomex ®", definition: "Trade name for a fire resistant synthetic material used in the manufacturingof flight suits and pants and shirts used by firefighters (see Aramid)."),
            Term(id: "Normal Fire Season", definition: "1) A season when weather, fire danger, and number and distribution of firesare about average. 2) Period of the year that normally comprises the fireseason."),
        ],
        "o" : [
            Term(id: "Operations Branch Director", definition: "Person under the direction of the operations section chief who is responsiblefor implementing that portion of the incident action plan appropriate to thebranch."),
            Term(id: "Operational Period", definition: "The period of time scheduled for execution of a given set of tactical actionsas specified in the Incident Action Plan. Operational periods can be of variouslengths, although usually not more than 24 hours."),
            Term(id: "Overhead", definition: "People assigned to supervisory positions, including incident commanders, commandstaff, general staff, directors, supervisors, and unit leaders."),
        ],
        "p" : [
            Term(id: "Pack Test", definition: "Used to determine the aerobic capacity of fire suppression and support personneland assign physical fitness scores. The test consists of walking a specifieddistance, with or without a weighted pack, in a predetermined period of time,with altitude corrections."),
            Term(id: "Paracargo", definition: "Anything dropped, or intended for dropping, from an aircraft by parachute,by other retarding devices, or by free fall."),
            Term(id: "Peak Fire Season", definition: "That period of the fire season during which fires are expected to ignite mostreadily, to burn with greater than average intensity, and to create damagesat an unacceptable level."),
            Term(id: "Personnel Protective Equipment (PPE)", definition: "All firefighting personnel must be equipped with proper equipment and clothingin order to mitigate the risk of injury from, or exposure to, hazardous conditionsencountered while working. PPE includes, but is not limited to: 8-inch high-lacedleather boots with lug soles, fire shelter, hard hat with chin strap, goggles,ear plugs, aramid shirts and trousers, leather gloves and individual firstaid kits."),
            Term(id: "Preparedness", definition: "Condition or degree of being ready to cope with a potential fire situation"),
            Term(id: "Prescribed Fire", definition: "Any fire ignited by management actions under certain, predetermined conditionsto meet specific objectives related to hazardous fuels or habitat improvement.A written, approved prescribed fire plan must exist, and NEPA requirementsmust be met, prior to ignition."),
            Term(id: "Prescribed Fire Plan (Burn Plan)", definition: "This document provides the prescribed fire burn boss information needed toimplement an individual prescribed fire project."),
            Term(id: "Prescription", definition: "Measurable criteria that define conditions under which a prescribed fire maybe ignited, guide selection of appropriate management responses, and indicateother required actions. Prescription criteria may include safety, economic,public health, environmental, geographic, administrative, social, or legalconsiderations."),
            Term(id: "Prevention", definition: "Activities directed at reducing the incidence of fires, including public education,law enforcement, personal contact, and reduction of fuel hazards."),
            Term(id: "Project Fire", definition: "A fire of such size or complexity that a large organization and prolongedactivity is required to suppress it."),
            Term(id: "Pulaski", definition: "A combination chopping and trenching tool, which combines a single-bittedaxe-blade with a narrow adze-like trenching blade fitted to a straight handle.Useful for grubbing or trenching in duff and matted roots. Well-balanced forchopping."),
        ],
//        "q" : [],
        "r" : [
            Term(id: "Radiant Burn", definition: "A burn received from a radiant heat source."),
            Term(id: "Radiant Heat Flux", definition: "The amount of heat flowing through a given area in a given time, usually expressedas calories/square centimeter/second."),
            Term(id: "Rappelling", definition: "Technique of landing specifically trained firefighters from hovering helicopters;involves sliding down ropes with the aid of friction-producing devices."),
            Term(id: "Rate of Spread", definition: "The relative activity of a fire in extending its horizontal dimensions. Itis expressed as a rate of increase of the total perimeter of the fire, asrate of forward spread of the fire front, or as rate of increase in area,depending on the intended use of the information. Usually it is expressedin chains or acres per hour for a specific period in the fire's history."),
            Term(id: "Reburn", definition: "The burning of an area that has been previously burned but that contains flammablefuel that ignites when burning conditions are more favorable; an area thathas reburned."),
            Term(id: "Red Card:", definition: "Fire qualification card issued to fire rated personsshowing their training needs and their qualifications to fill specified firesuppression and support positions in a large fire suppression or incidentorganization."),
            Term(id: "Red Flag Warning", definition: "Term used by fire weather forecasters to alert forecast users to an ongoingor imminent critical fire weather pattern."),
            Term(id: "Rehabilitation", definition: "The activities necessary to repair damage or disturbance caused by wildlandfires or the fire suppression activity."),
            Term(id: "Relative Humidity (Rh)", definition: "The ratio of the amount of moisture in the air, to the maximum amount of moisturethat air would contain if it were saturated. The ratio of the actual vaporpressure to the saturated vapor pressure."),
            Term(id: "Remote Automatic Weather Station (RAWS)", definition: "An apparatus that automatically acquires, processes, and stores local weatherdata for later transmission to the GOES Satellite, from which the data isre-transmitted to an earth-receiving station for use in the National FireDanger Rating System."),
            Term(id: "Resources", definition: "1) Personnel, equipment, services and supplies available, or potentially available,for assignment to incidents. 2) The natural resources of an area, such astimber, crass, watershed values, recreation values, and wildlife habitat."),
            Term(id: "Resource Management Plan (RMP)", definition: "A document prepared by field office staff with public participation and approvedby field office managers that provides general guidance and direction forland management activities at a field office. The RMP identifies the needfor fire in a particular area and for a specific benefit."),
            Term(id: "Resource Order", definition: "An order placed for firefighting or support resources."),
            Term(id: "Retardant", definition: "A substance or chemical agent which reduced the flammability of combustibles."),
            Term(id: "Run (of a fire)", definition: "The rapid advance of the head of a fire with a marked change in fire lineintensity and rate of spread from that noted before and after the advance."),
            Term(id: "Running", definition: "A rapidly spreading surface fire with a well-defined head."),
        ],
        "s" : [
            Term(id: "Safety Zone", definition: "An area cleared of flammable materials used for escape in the event the lineis outflanked or in case a spot fire causes fuels outside the control lineto render the line unsafe. In firing operations, crews progress so as to maintaina safety zone close at hand allowing the fuels inside the control line tobe consumed before going ahead. Safety zones may also be constructed as integralparts of fuel breaks; they are greatly enlarged areas which can be used withrelative safety by firefighters and their equipment in the event of a blowupin the vicinity."),
            Term(id: "Scratch Line", definition: "An unfinished preliminary fire line hastily established or built as an emergencymeasure to check the spread of fire."),
            Term(id: "Severity Funding", definition: "Funds provided to increase wildland fire suppression response capability necessitatedby abnormal weather patterns, extended drought, or other events causing abnormalincrease in the fire potential and/or danger."),
            Term(id: "Single Resource", definition: "An individual, a piece of equipment and its personnel complement, or a crewor team of individuals with an identified work supervisor that can be usedon an incident."),
            Term(id: "Size-up", definition: "To evaluate a fire to determine a course of action for fire suppression."),
            Term(id: "Slash", definition: "Debris left after logging, pruning, thinning or brush cutting; includes logs,chips, bark, branches, stumps and broken understory trees or brush."),
            Term(id: "Sling Load", definition: "Any cargo carried beneath a helicopter and attached by a lead line and swivel."),
            Term(id: "Slop-over", definition: "A fire edge that crosses a control line or natural barrier intended to containthe fire."),
            Term(id: "Smokejumper", definition: "A firefighter who travels to fires by aircraft and parachute."),
            Term(id: "Smoke Management", definition: "Application of fire intensities and meteorological processes to minimize degradationof air quality during prescribed fires."),
            Term(id: "Smoldering Fire", definition: "A fire burning without flame and barely spreading."),
            Term(id: "Snag", definition: "A standing dead tree or part of a dead tree from which at least the smallerbranches have fallen."),
            Term(id: "Spark Arrester", definition: "A device installed in a chimney, flue, or exhaust pipe to stop the emissionof sparks and burning fragments."),
            Term(id: "Spot Fire", definition: "A fire ignited outside the perimeter of the main fire by flying sparks orembers."),
            Term(id: "Spot Weather Forecast", definition: "A special forecast issued to fit the time, topography, and weather of eachspecific fire. These forecasts are issued upon request of the user agencyand are more detailed, timely, and specific than zone forecasts."),
            Term(id: "Spotter", definition: "In smokejumping, the person responsible for selecting drop targets and supervisingall aspects of dropping smokejumpers."),
            Term(id: "Spotting", definition: "Behavior of a fire producing sparks or embers that are carried by the windand start new fires beyond the zone of direct ignition by the main fire."),
            Term(id: "Staging Area", definition: "Locations set up at an incident where resources can be placed while awaitinga tactical assignment on a three-minute available basis. Staging areas aremanaged by the operations section."),
            Term(id: "Strategy", definition: "The science and art of command as applied to the overall planning and conductof an incident."),
            Term(id: "Strike Team", definition: "Specified combinations of the same kind and type of resources, with commoncommunications, and a leader."),
            Term(id: "Strike Team Leader", definition: "Person responsible to a division/group supervisor for performing tacticalassignments given to the strike team."),
            Term(id: "Structure Fire", definition: "Fire originating in and burning any part or all of any building, shelter,or other structure."),
            Term(id: "Suppressant", definition: "An agent, such as water or foam, used to extinguish the flaming and glowingphases of combustion when direction applied to burning fuels."),
            Term(id: "Suppression", definition: "All the work of extinguishing or containing a fire, beginning with its discovery."),
            Term(id: "Surface Fuels", definition: "Loose surface litter on the soil surface, normally consisting of fallen leavesor needles, twigs, bark, cones, and small branches that have not yet decayedenough to lose their identity; also grasses, forbs, low and medium shrubs,tree seedlings, heavier branchwood, downed logs, and stumps interspersed withor partially replacing the litter."),
            Term(id: "Swamper", definition: "(1) A worker who assists fallers and/or sawyers by clearing away brush, limbsand small trees. Carries fuel, oil and tools and watches for dangerous situations.(2) A worker on a dozer crew who pulls winch line, helps maintain equipment,etc., to speed suppression work on a fire."),
        ],
        "t" : [
            Term(id: "Tactics", definition: "Deploying and directing resources on an incident to accomplish the objectivesdesignated by strategy."),
            Term(id: "Temporary Flight Restrictions (TFR)", definition: "A restriction requested by an agency and put into effect by the Federal AviationAdministration in the vicinity of an incident which restricts the operationof nonessential aircraft in the airspace around that incident."),
            Term(id: "Terra Torch ®", definition: "Device for throwing a stream of flaming liquid, used to facilitate rapid ignitionduring burn out operations on a wildland fire or during a prescribed fireoperation."),
            Term(id: "Test Fire", definition: "A small fire ignited within the planned burn unit to determine the characteristicof the prescribed fire, such as fire behavior, detection performance and controlmeasures."),
            Term(id: "Timelag", definition: "Time needed under specified conditions for a fuel particle to lose about 63percent of the difference between its initial moisture content and its equilibriummoisture content. If conditions remain unchanged, a fuel will reach 95 percentof its equilibrium moisture content after four timelag periods."),
            Term(id: "Torching", definition: "The ignition and flare-up of a tree or small group of trees, usually frombottom to top."),
            Term(id: "Two-way Radio", definition: "Radio equipment with transmitters in mobile units on the same frequency asthe base station, permitting conversation in two directions using the samefrequency in turn."),
            Term(id: "Type", definition: "The capability of a firefighting resource in comparison to another type. Type1 usually means a greater capability due to power, size, or capacity."),
        ],
        "u" : [
            Term(id: "Uncontrolled Fire:", definition: "Any fire which threatens to destroy life,property, or natural resources, and"),
            Term(id: "Underburn", definition: "A fire that consumes surface fuels but not trees or shrubs. (See Surface Fuels.)"),
        ],
        "v" : [
            Term(id: "Vectors", definition: "Directions of fire spread as related to rate of spread calculations (in degreesfrom upslope)."),
            Term(id: "Volunteer Fire Department (VFD)", definition: "A fire department of which some or all members are unpaid."),
        ],
        "w" : [
            Term(id: "Water Tender", definition: "A ground vehicle capable of transporting specified quantities of water."),
            Term(id: "Weather Information and Management System (WIMS)", definition: "An interactive computer system designed to accommodate the weather informationneeds of all federal and state natural resource management agencies. Providestimely access to weather forecasts, current and historical weather data, theNational Fire Danger Rating System (NFDRS), and the National Interagency FireManagement Integrated Database (NIFMID)."),
            Term(id: "Wet Line", definition: "A line of water, or water and chemical retardant, sprayed along the ground,that serves as a temporary control line from which to ignite or stop a low-intensityfire."),
            Term(id: "Wildland Fire", definition: "Any nonstructure fire, other than prescribed fire, that occurs in the wildland."),
            Term(id: "Wildland Fire Implementation Plan (WFIP)", definition: "A progressively developed assessment and operational management plan thatdocuments the analysis and selection of strategies and describes the appropriatemanagement response for a wildland fire being managed for resource benefits."),
            Term(id: "Wildland Fire Situation Analysis (WFSA)", definition: "A decision-making process that evaluates alternative suppression strategiesagainst selected environmental, social, political, and economic criteria.Provides a record of decisions."),
            Term(id: "Wildland Fire Use", definition: "The management of naturally ignited wildland fires to accomplish specificprestated resource management objectives in predefined geographic areas outlinedin Fire Management Plans."),
            Term(id: "Wildland Urban Interface", definition: "The line, area or zone where structures and other human development meet orintermingle with undeveloped wildland or vegetative fuels."),
            Term(id: "Wind Vectors", definition: "Wind directions used to calculate fire behavior."),
        ],
//        "x" : [],
//        "y" : [],
//        "z" : [],
    ]
    
    static func getAllWords() -> [Term] {
        return Array(GlossaryDatabase.terms.values.joined())
    }
}
