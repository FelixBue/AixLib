within AixLib.Fluid.Storage.BaseClasses;
model HeatTransferLambdaEffTanh "Heat transfer with buoyancy and tanh transition"
  extends AixLib.Fluid.Storage.BaseClasses.PartialHeatTransferLayers;

  Modelica.SIunits.HeatFlowRate[n-1] qFlow "Heat flow rate from segment i+1 to i";

  parameter Real t_Trans(unit="s")=500 "Transition time";

protected
  parameter Real kappa=0.41 "Karman constant";
  parameter Modelica.SIunits.Length height=data.hTank/n
    "Height of fluid layers";
  Real beta=350e-6 "Thermal expansion coefficient in 1/K";
  parameter Modelica.SIunits.Area A=Modelica.Constants.pi/4*data.dTank^2
    "Area of heat transfer between layers";
   parameter Modelica.SIunits.Density rho=1000
    "Density, used to compute fluid mass";
   parameter Modelica.SIunits.SpecificHeatCapacity c_p=4180
    "Specific heat capacity";
 Modelica.SIunits.TemperatureDifference dT[n-1]
    "Temperature difference between adjoining volumes";
  Modelica.SIunits.ThermalConductance[n-1] k "Effective heat transfer coefficient";
  Modelica.SIunits.ThermalConductivity[ n-1] lambda "Effective heat conductivity";
  parameter Modelica.SIunits.ThermalConductivity lambdaWater=0.64
    "Thermal conductivity of water";
public
  BaseLib.Utilities.VariableTransition selectTrans[n - 1](each t_Trans=t_Trans,
      starWith_u1=false)
    "Smooth transition between nominal control strategy u1 and selected curve u2"
    annotation (Placement(transformation(extent={{-20,0},{0,20}},  rotation=
           0)));

equation
  for i in 1:n-1 loop
    dT[i] = therm[i].T-therm[i+1].T;
    lambda[i]^2=noEvent(max((9.81*beta*dT[i]/height)*(2/3*rho*c_p*kappa*height^2)^2,0));
    selectTrans[i].u1=lambda[i];
    selectTrans[i].u=dT[i]>0;
    selectTrans[i].u2=0;
    k[i]=(selectTrans[i].y+lambdaWater)*A/height;
    qFlow[i] = k[i]*dT[i];
  end for;
  // Positive heat flows here mean negative heat flows for the fluid layers
  therm[1].Q_flow = qFlow[1];
  for i in 2:n-1 loop
       therm[i].Q_flow = -qFlow[i-1]+qFlow[i];
  end for;
  therm[n].Q_flow = -qFlow[n-1];
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Model for heat transfer between buffer storage layers. </p>
<h4><font color=\"#008000\">Concept</font></h4>
<p>Models conductance of water and buoyancy according to Viskanta et al., 1997.
An effective heat conductivity is therefore calculated. Used in BufferStorage
model. In addition, a tanh function is used for the transition of the buoyancy
model (VariableTransition model). Attention: the initial value of the
FullTransition model is 0.5. This may lead to a mixture of the storage at the
beginning of the simulation.</p>
<h4><font color=\"#008000\">Sources</font></h4>
<p>R. Viskanta, A. KaraIds: Interferometric observations of the temperature
structure in water cooled or heated from above. <i>Advances in Water
Resources,</i> volume 1, 1977, pages 57-69. Bibtex-Key [R.VISKANTA1977]</p>
</html>",
   revisions="<html>
<ul>
<li><i>October 12, 2016&nbsp;</i> by Marcus Fuchs:<br/>Add comments and fix documentation</li>
<li><i>October 11, 2016&nbsp;</i> by Sebastian Stinner:<br/>Added to AixLib</li>
<li><i>December 10, 2013</i> by Kristian Huchtemann:<br/>New implementation in source code. Documentation.</li>
<li><i>October 2, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately </li>
</ul>
</html>"),
    Icon(graphics={Text(
          extent={{-100,-60},{100,-100}},
          lineColor={0,0,255},
          textString="%name")}));
end HeatTransferLambdaEffTanh;
