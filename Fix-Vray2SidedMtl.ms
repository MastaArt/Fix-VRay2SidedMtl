/* 
	Fix Vray2SidedMtl 
	MastaMan
	GNU  GPL v3.0
	
	
	This script helps to fix bug with Vray2SidedMtl in V-Ray 3.x.x .
	Vray2SidedMtl replaced to Front Material.
*/

try(closeRolloutFloater fFix2Sided)catch()
global fFix2Sided = newRolloutFloater "Fix Vray2SidedMtl" 200 180
global rFix2Sided

rollout rFix2Sided "Fix Vray2SidedMtl"
(
	button btnStartFix "Start Fix" height:35 width: 160
	
	fn is2Sided m =
	(
		return classOf m == Vray2SidedMtl
	)

	fn fix2Sided =
	(	
		undo "Fix Vray2SidedMtl" on 
		(	
			for i in geometry where i.material != undefined do
			(
				case (classOf i.material) of
				(
					MultiMaterial: for ii in 1 to i.material.count where is2Sided (i.material[ii]) do i.material[ii] = i.material[ii].frontMtl
					default: if(is2Sided (i.material)) do i.material = i.material.frontMtl
				)
			)
		)
	)
)

rollout rAbout "About" 
(
	label lblName "MastaMan" 
	label lblVer "1.0.0" 
	
	label lblAuthor "MastaMan" height: 30
	label lblCopy "GNU GPL v3.0"  height: 30
)

addRollout rFix2Sided fFix2Sided rolledUp:false 
addRollout rAbout fFix2Sided rolledUp:true