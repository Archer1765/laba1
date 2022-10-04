(deffunction ask-value (?question)
    (print ?question)
    (bind ?answer (read))
    ?answer
    )
(deffunction ask-question (?question $?allowed-values)
    (print ?question)
    (bind ?answer (read))
    (if (lexemep ?answer) 
        then (bind ?answer (lowcase ?answer))
	    )
    (while (not (member$ ?answer ?allowed-values)) do
        (print ?question)
        (bind ?answer (read))
        (if (lexemep ?answer) 
            then (bind ?answer (lowcase ?answer))
		    )
	    )
    ?answer
    )
(deffunction yes-or-no (?question)
    (bind ?response (ask-question ?question yes no y n))
    (if (or (eq ?response yes) (eq ?response y))
        then yes 
        else no
	    )
    )
(defrule determenite-temp "Определение температуры"
    (not (solution ?))
    (not (temp ?))
    =>
    (assert (temp (ask-value "Какая у Вас температура: ")))
    )
(defrule determenite-temp-is-normal "Определение нормальной температуры"
    (not (solution ?))
    (not (temp-normal ?))
    (temp ?value)
    =>
    (if (and (< ?value 37.0) (> ?value 35.0))
        then (assert (temp-normal yes))
        else (assert (temp-normal no))
	    )
    )
(defrule determenite-heaviness-in-stomach "Определение тяжести в желудке"
    (not (solution ?))
    (not (stomach ?))
    =>
    (assert (stomach (yes-or-no "Есть ли у Вас тяжесть в желудке?: ")))
    )
(defrule determenite-diarrhea "Определение диареи"
    (not (solution ?))
    (not (diarrhea ?))
    =>
    (assert (diarrhea (yes-or-no "Есть ли у Вас диарея?: ")))
    )
(defrule determenite-loss-of-sense-of-smell "Определение потери обоняния"
    (not (solution ?))
    (not (sense ?))
    =>
    (assert (sense (yes-or-no "Вы потеряли обоняние?: ")))
    )
(defrule determenite-dry-hard-crusts "Определение сухой твердой корочки на коже"
    (not (solution ?))
    (not (crusts ?))
    =>
    (assert (crusts (yes-or-no "Есть ли у Вас сухая твердая корочка на коже?: ")))
    )
(defrule determenite-burning-pain "Определение жгучей боли на коже"
    (not (solution ?))
    (not (pain ?))
    =>
    (assert (pain (yes-or-no "Ощущаете ли Вы жгучую боль на коже?: ")))
    )
(defrule determenite-slouching "Определение сутулости"
    (not (solution ?))
    (not (slouching ?))
    =>
    (assert (slouching (yes-or-no "Есть ли у Вас сутулость?: ")))
    )
(defrule determenite-curvature-of-spine "Определение искривления позвоночника"
    (not (solution ?))
    (not (curvature ?))
    =>
    (assert (curvature (yes-or-no "Есть ли у Вас искривление позвоночника?: ")))
    )
(defrule determenite-bleeding-gums "Определение кровоточивости десен"
    (not (solution ?))
    (not (gums ?))
    =>
    (assert (gums (yes-or-no "Есть ли у Вас кровоточивость десен?: ")))
    )
(defrule determenite-changing-color-of-tooth-enamel "Определение изменения цвета зубной эмали"
    (not (solution ?))
    (not (changing-color ?))
    =>
    (assert (changing-color (yes-or-no "Есть ли у Вас изменение цвета зубной эмали?: ")))
    )
(defrule determenite-insufficient-thickness-of-enamel-layer "Определение недостаточной толщины слоя эмали"
    (not (solution ?))
    (not (insufficient-thickness ?))
    =>
    (assert (insufficient-thickness (yes-or-no "Есть ли у Вас недостаточная толщина слоя эмали?: ")))
    )
(defrule determenite-fatigue "Определение усталости"
    (not (solution ?))
    (not (fatigue ?))
    =>
    (assert (fatigue (yes-or-no "Есть ли у Вас усталость?: ")))
    )
(defrule determenite-change-in-appetite "Определение изменения аппетита"
    (not (solution ?))
    (not (appetite ?))
    =>
    (assert (appetite (yes-or-no "Есть ли у Вас изменение аппетита?: ")))
    )
(defrule determenite-muscle-pain "Определение мышечной боли"
    (not (solution ?))
    (not (muscle-pain ?))
    =>
    (assert (muscle-pain (yes-or-no "Есть ли у Вас мышечная боль?: ")))
    )
(defrule determenite-irritability "Определение раздражительности"
    (not (solution ?))
    (not (irritability ?))
    =>
    (assert (irritability (yes-or-no "Есть ли у Вас раздражительность?: ")))
    )
(defrule diagnosis-of-pancreatitis "Диагноз панкреатит"
    (and 
	    (and 
		    (temp-normal yes) 
			(stomach no)
			) 
	    (diarrhea yes)
	    )
    (not (solution ?))
    =>
    (assert (pancreatitis yes))
	(print "Ваш диагноз - панкреатит" crlf)
	)
(defrule diagnosis-of-gastritis "Диагноз гастрит"
    (and 
	    (and 
		    (temp-normal yes) 
			(stomach yes)
			) 
	    (diarrhea yes)
	    )
    (not (solution ?))
    =>
    (assert (gastritis yes))
	(print "Ваш диагноз - гастрит" crlf)
	)
(defrule diagnosis-of-covid "Диагноз ковид"
    (and 
	    (and 
		    (temp-normal no) 
			(sense yes)
			) 
	    (diarrhea yes)
	    )
    (not (solution ?))
    =>
    (assert (covid yes))
	(print "Ваш диагноз - covid-19" crlf)
	)
(defrule diagnosis-of-flu "Диагноз грипп"
    (and 
	    (and 
		    (temp-normal no) 
			(sense no)
			) 
	    (diarrhea no)
	    )
    (not (solution ?))
    =>
    (assert (flu yes))
	(print "Ваш диагноз - грипп" crlf)
	)
(defrule diagnosis-of-chemical-burn "Диагноз хим ожог"
    (and 
	    (crusts yes) 
		(pain no)
	    )
    (not (solution ?))
    =>
    (assert (chemical-burn yes))
	(print "Ваш диагноз - химический ожог" crlf)
	)
(defrule diagnosis-of-thermal-burn "Диагноз термич ожог"
    (and 
	    (crusts no) 
		(pain yes)
	    )
    (not (solution ?))
    =>
    (assert (thermal-burn yes))
	(print "Ваш диагноз - термический ожога" crlf)
	)
(defrule diagnosis-of-kyphosis "Диагноз кифоз"
    (and 
	    (slouching yes) 
		(curvature no)
	    )
    (not (solution ?))
    =>
    (assert (kyphosis yes))
	(print "Ваш диагноз - кифоз" crlf)
	)
(defrule diagnosis-of-scoliosis "Диагноз сколиоз"
    (and 
	    (slouching no) 
		(curvature yes)
	    )
    (not (solution ?))
    =>
    (assert (scoliosis yes))
	(print "Ваш диагноз - сколиоз" crlf)
	)
(defrule diagnosis-of-plaque "Диагноз зубной налет"
    (and 
	    (and 
		    (gums yes) 
			(changing-color yes)
			) 
	    (insufficient-thickness no)
	    )
    (not (solution ?))
    =>
    (assert (plaque yes))
	(print "Ваш диагноз - зубной налет" crlf)
	)
(defrule diagnosis-of-gingivitis "Диагноз гингивит"
    (and 
	    (gums yes) 
		(changing-color no)
	    )
    (not (solution ?))
    =>
    (assert (gingivitis yes))
	(print "Ваш диагноз - гингивит" crlf)
	)
(defrule diagnosis-of-hypoplasia "Диагноз гипоплазия"
    (and 
	    (and 
		    (gums no) 
			(changing-color yes)
			) 
	    (insufficient-thickness yes)
	    )
    (not (solution ?))
    =>
    (assert (hypoplasia yes))
	(print "Ваш диагноз - гипоплазия" crlf)
	)
(defrule diagnosis-of-malocclusion "Диагноз неправильный прикус"
    (and 
	    (gums no) 
		(slouching yes)
	    )
    (not (solution ?))
    =>
    (assert (malocclusion yes))
	(print "Ваш диагноз - неправильный прикус" crlf)
	)
(defrule diagnosis-of-midlife-crisis "Диагноз кризис среднего возраста"
    (and 
	    (and 
		    (fatigue yes) 
			(appetite no)
			) 
	    (muscle-pain no)
	    )
    (not (solution ?))
    =>
    (assert (midlife-crisis yes))
	(print "Ваш диагноз - кризис среднего возраста" crlf)
	)
(defrule diagnosis-of-mild-neurosis "Диагноз легкий невроз"
    (and 
	    (and 
		    (fatigue yes) 
			(appetite no)
			) 
	    (muscle-pain yes)
	    )
    (not (solution ?))
    =>
    (assert (mild-neurosis yes))
	(print "Ваш диагноз - легкий невроз" crlf)
	)
(defrule diagnosis-of-depression "Диагноз депрессия"
    (and 
	    (and 
		    (fatigue yes) 
			(appetite yes)
			) 
	    (irritability no)
	    )
    (not (solution ?))
    =>
    (assert (depression yes))
	(print "Ваш диагноз - депрессия" crlf)
	)
(defrule diagnosis-of-psychosis "Диагноз психоз"
    (and 
	    (and 
		    (fatigue no) 
			(appetite yes)
			) 
	    (irritability yes)
	    )
    (not (solution ?))
    =>
    (assert (psychosis yes))
	(print "Ваш диагноз - психоз" crlf)
	)
(defrule doc-gastroenterologist "Врач гастроэнтеролог"
    (or 
	    (pancreatitis yes) 
		(gastritis yes)
	    )
    (not (solution ?))
    =>
    (assert (gastroenterologist yes))
	(print "Обратитесь к гастроэнтерологу" crlf)
	)
(defrule doc-therapist "Врач терапевт"
    (or 
	    (covid yes) 
		(flu yes)
	    )
    (not (solution ?))
    =>
    (assert (therapist yes))
	(print "Обратитесь к терапевту" crlf)
	)
(defrule doc-traumatologist "Врач травматолог"
    (or 
	    (chemical-burn yes) 
		(thermal-burn yes)
	    )
    (not (solution ?))
    =>
    (assert (traumatologist yes))
	(print "Обратитесь к травматологу" crlf)
	)
(defrule doc-orthopedist "Врач ортопед"
    (or 
	    (kyphosis yes) 
		(scoliosis yes)
	    )
    (not (solution ?))
    =>
    (assert (orthopedist yes))
	(print "Обратитесь к ортопеду" crlf)
	)
(defrule doc-dentist "Врач стоматолог"
    (or 
	    (plaque yes) 
		(gingivitis yes)
	    )
    (not (solution ?))
    =>
    (assert (dentist yes))
	(print "Обратитесь к стоматологу" crlf)
	)
(defrule doc-orthodontist "Врач ортодонт"
    (or 
	    (hypoplasia yes) 
		(malocclusion yes)
	    )
    (not (solution ?))
    =>
    (assert (orthodontist yes))
	(print "Обратитесь к ортодонту" crlf)
	)
(defrule doc-psychologist "Врач психолог"
    (or 
	    (midlife-crisis yes) 
		(mild-neurosis yes)
	    )
    (not (solution ?))
    =>
    (assert (psychologist yes))
	(print "Обратитесь к психологу" crlf)
	)
(defrule doc-psychiatrist "Врач психиатр"
    (or 
	    (depression yes) 
		(psychosis yes)
	    )
    (not (solution ?))
    =>
    (assert (psychiatrist yes))
	(print "Обратитесь к психиатру" crlf)
	)
(defrule therapeutic-department "Терапевтическое отделение"
    (or 
	    (gastroenterologist yes) 
		(therapist yes)
	    )
    (not (solution ?))
    =>
    (assert (therapeutic-d yes))
	(print "В терапевтическое отделение" crlf)
	)
(defrule traumatology-department "Травматологическое отделение"
    (or 
	    (traumatologist yes) 
		(orthopedist yes)
	    )
    (not (solution ?))
    =>
    (assert (traumatology-d yes))
	(print "В травматологическое отделение" crlf)
	)
(defrule dental-department "Стоматологическое отделение"
    (or 
	    (dentist yes) 
		(orthodontist yes)
	    )
    (not (solution ?))
    =>
    (assert (dental-d yes))
	(print "В стоматологическое отделение" crlf)
	)
(defrule psychiatric-department "Психиатрическое отделение"
    (or 
	    (psychologist yes) 
		(psychiatrist yes)
	    )
    (not (solution ?))
    =>
    (assert (psychiatric-d yes))
	(print "В психиатрическое отделение" crlf)
	)
(defrule city-clinical-polyclinic "Городская клиническая поликлиника"
    (or 
	    (therapeutic-d yes) 
		(traumatology-d yes)
	    )
    (not (solution ?))
    =>
    (assert (city-polyclinic yes))
	(print "Рекомендация - идите в городскую клиническую поликлинику" crlf)
	)
(defrule alpha-medical-center "Мед центр Альфа"
    (or 
	    (traumatology-d yes) 
		(dental-d yes)
	    )
    (not (solution ?))
    =>
    (assert (alpha yes))
	(print "Рекомендация - идите в медицинский центр Альфа" crlf)
	)
(defrule medsi-medical-center "Мед центр Медси"
    (or 
	    (psychiatric-d yes) 
		(dental-d yes)
	    )
    (not (solution ?))
    =>
    (assert (medsi yes))
	(print "Рекомендация - идите в медицинский центр Медси" crlf)
	)