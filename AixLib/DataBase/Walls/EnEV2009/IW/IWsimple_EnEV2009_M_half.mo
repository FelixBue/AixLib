within AixLib.DataBase.Walls.EnEV2009.IW;

record IWsimple_EnEV2009_M_half "Inner wall simple after EnEV, for building of type M (mittel), only half"
  extends WallBaseDataDefinition(n(min = 1) = 2 "Number of wall layers", d = {0.0575, 0.015} "Thickness of wall layers", rho = {1000, 1200} "Density of wall layers", lambda = {0.315, 0.51} "Thermal conductivity of wall layers", c = {1000, 1000} "Specific heat capacity of wall layers", eps = 0.95 "Emissivity of inner wall surface");
  annotation(Documentation(revisions = "<html>
 <p><ul>
 <li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
 <li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
 </ul></p>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
 <p>Norm: </p>
 <ul>
 <li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
 </ul>
 </html>"));
end IWsimple_EnEV2009_M_half;