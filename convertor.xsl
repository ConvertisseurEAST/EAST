<?xml version ="1.0" encoding="ISO-8859-1" ?>

<!-- REFERENCE AUX ESPACES DE NOMS -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dom="http://www.w3.org/2001/xml-events" xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0" xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0" xmlns:presentation="urn:oasis:names:tc:opendocument:xmlns:presentation:1.0" xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0" xmlns:smil="urn:oasis:names:tc:opendocument:xmlns:smil-compatible:1.0" xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0">


<!-- Méthode de sortie = XML -->
<xsl:output 
  	method="xml"
  	encoding="ISO-8859-1"
 	indent="yes" 
 />

	<!-- On se place au niveau de la présentation -->
	<xsl:template match="office:document-content/office:body/office:presentation">

		<!--récupération du pied de page pour aller en pied de page droit -->
		<xsl:for-each select="draw:page">
			<xsl:if test="@draw:name= 'Slide1'">
				<PIEDPAGE_GAUCHE>
					<xsl:value-of select="draw:frame[2]" />
				</PIEDPAGE_GAUCHE>
			</xsl:if>
		</xsl:for-each>

		<!-- Récupération de la date qui est le pied de page gauche -->

		<xsl:for-each select="draw:page">
			<xsl:if test="@draw:name= 'Slide1'">
				<PIEDPAGE_DROIT>
					<xsl:value-of select="draw:frame" />
				</PIEDPAGE_DROIT>
			</xsl:if>
		</xsl:for-each>

		<!--récupération du contenu de la première page -->
		<xsl:for-each select="draw:page">
			<xsl:if test="@draw:name= 'Slide1'">
				<PAGE_TITRE>
					<TITRE>
						<xsl:value-of select="draw:frame/draw:text-box" />		
					</TITRE>
					<SOUS_TITRE>
						<xsl:value-of select="draw:frame[2]" />
					</SOUS_TITRE>
				</PAGE_TITRE>
			</xsl:if>
		</xsl:for-each>

		<!-- parcours de toutes les pages sauf la première qui est une page de titre -->
		<xsl:for-each select="draw:page">
			<xsl:if test="@draw:name!= 'Slide1'">
			<!-- On choisit de délimiter une page (slide/transparent) par une balise section -->
				<PARTIE>
				<SECTION>
					<!-- parcours de toutes les zones de texte d'une slide -->
					<xsl:for-each select="draw:frame">
						<!-- Si c'est une frame de type titre, on ajoute le titre -->
						<xsl:if test="contains(@draw:name, 'Title')">
							<TITRE>	
								<xsl:value-of select="." />
							</TITRE>
						</xsl:if>
					</xsl:for-each>
					<xsl:for-each select="draw:frame">	
						<xsl:if test="@presentation:class= 'outline'">

							<!-- si c'est du niveau 1 et que le jetonNiveau 1 est libre-->
							<!-- on ouvre la liste -->
							<xsl:if test="draw:text-box/text:list/text:list-item/text:p">
								<LISTE couleur_puce="green" type="square">
									<xsl:for-each select="draw:text-box/text:list/text:list-item">
										<EL>
											<xsl:value-of select="text:p" />
											<xsl:if test="text:list/text:list-item">
												<LISTE couleur_puce="orange" type="disc">
													<xsl:for-each select="text:list/text:list-item">
														<EL>
															<xsl:value-of select="text:p" />
															<xsl:if test="text:list/text:list-item">
																<LISTE couleur_puce="green" type="circle">
																	<xsl:for-each select="text:list/text:list-item">
																		<EL>
																			<xsl:value-of select="text:p" />
																		</EL>
																	</xsl:for-each>
																</LISTE>
															</xsl:if>
														</EL>
													</xsl:for-each>
												</LISTE>
											</xsl:if>
										</EL>
									</xsl:for-each>
								</LISTE>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
				</SECTION>
			</PARTIE>
			</xsl:if>
		</xsl:for-each>

	</xsl:template>
	
</xsl:stylesheet>