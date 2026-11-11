// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get undo => 'Desfazer';

  @override
  String duplicatedNamed(String name) {
    return '“$name” duplicado';
  }

  @override
  String deletedNamed(String name) {
    return '“$name” apagado';
  }

  @override
  String get when => 'Quando?';

  @override
  String get newAtTime => 'Num horário';

  @override
  String get newAtTimeHint => 'Todo dia útil às 7:00, uma vez às 15:30…';

  @override
  String get newAroundEvent => 'Em torno de um evento';

  @override
  String get newAroundEventHint => 'Busque na agenda, no Shabat e no sol, e toque antes, na hora ou depois';

  @override
  String get editThisAlarm => 'Editar este alarme';

  @override
  String editNamed(String name) {
    return 'Editar “$name”';
  }

  @override
  String get preset => 'modelo';

  @override
  String get editThisCalendarRule => 'Editar esta regra da agenda';

  @override
  String get ringThisOneAfterAll => 'Tocar este afinal';

  @override
  String get skipJustThisOne => 'Pular só este';

  @override
  String get renameGroup => 'Renomear grupo';

  @override
  String quickSet(String label, String time) {
    return '$label · toca às $time';
  }

  @override
  String get newAlarm => 'Novo alarme';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => 'Modo bloqueio';

  @override
  String get calendars => 'Agendas';

  @override
  String get settings => 'Ajustes';

  @override
  String get nextAlarmHeading => 'PRÓXIMO ALARME';

  @override
  String get nothingSet => 'Nada marcado';

  @override
  String get tagline => 'Tudo na sua hora.';

  @override
  String sunriseAt(String time) {
    return 'Nascer do sol $time';
  }

  @override
  String sunsetAt(String time) {
    return 'Pôr do sol $time';
  }

  @override
  String get alarmsMayNotRing => 'Seus alarmes podem não tocar';

  @override
  String get tapToFixIt => 'Toque para resolver';

  @override
  String inMinutes(int minutes) {
    return 'Em $minutes min';
  }

  @override
  String get atSunset => 'No pôr do sol';

  @override
  String get sunset => 'Pôr do sol';

  @override
  String get shabbatModeIsOn => 'MODO SHABAT ATIVO';

  @override
  String nextInCity(String city) {
    return 'PRÓXIMO · $city';
  }

  @override
  String get candleLighting => 'Acendimento das velas';

  @override
  String get havdalah => 'Havdalá';

  @override
  String get shabbatAndFestivals => 'Shabat e festas';

  @override
  String get yourAlarmsHeading => 'SEUS ALARMES';

  @override
  String get tapWhenToAdd => 'Toque em Quando? para criar um alarme.';

  @override
  String get aroundEventsHeading => 'EM TORNO DE EVENTOS';

  @override
  String searchFor(String words) {
    return 'busca: $words';
  }

  @override
  String get thisWeekHeading => 'ALARMES DESTA SEMANA';

  @override
  String get noAlarmsThisWeek => 'Nenhum alarme nos próximos 7 dias.';

  @override
  String get alarmsSetThemselves => 'Os alarmes se ajustam sozinhos neste celular sempre que você muda algo.';

  @override
  String cityTime(String city) {
    return 'horário de $city';
  }

  @override
  String get more => 'Mais';

  @override
  String get turnOff => 'Desligar';

  @override
  String get turnOn => 'Ligar';

  @override
  String get duplicate => 'Duplicar';

  @override
  String get delete => 'Apagar';

  @override
  String get inOneHour => 'Em 1 hora';

  @override
  String get logoLabel => 'Logo do Quando?';

  @override
  String get noTimesSet => 'Nenhum horário';

  @override
  String get atTheMoment => 'na hora';

  @override
  String timesRange(int count, String from, String to) {
    return '$count vezes · de $from a $to';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n dias', one: '1 dia');
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n horas', one: '1 hora');
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n minutos', one: '1 minuto');
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n segundos', one: '1 segundo');
    return '$_temp0';
  }

  @override
  String get now => 'agora';

  @override
  String spanBefore(String span) {
    return '$span antes';
  }

  @override
  String spanAfter(String span) {
    return '$span depois';
  }

  @override
  String alarmCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n alarmes', one: '1 alarme');
    return '$_temp0';
  }

  @override
  String get allOn => 'todos ligados';

  @override
  String get allOff => 'todos desligados';

  @override
  String someOn(int n) {
    return '$n ligados';
  }

  @override
  String skippedBody(String body) {
    return 'Pulado · $body';
  }

  @override
  String timeToTime(String from, String to) {
    return '$from a $to';
  }

  @override
  String skippedCount(int n) {
    return '$n pulados';
  }

  @override
  String get sunNoRiseSet => 'Hoje o sol não nasce nem se põe aqui';

  @override
  String sunProgress(int percent) {
    return 'O sol já percorreu $percent% do dia';
  }

  @override
  String get sunIsDown => 'O sol já se pôs';

  @override
  String get searchCity => 'Buscar uma cidade';

  @override
  String get tomorrowLower => 'amanhã';

  @override
  String get yesterdayLower => 'ontem';

  @override
  String get worldClocksHeading => 'RELÓGIOS DO MUNDO';

  @override
  String get add => 'Adicionar';

  @override
  String cityHere(String city) {
    return '$city · aqui';
  }

  @override
  String get worldClocksHint =>
      'Adicione cidades para ver o horário delas aqui. Deslize para a esquerda para remover.';

  @override
  String get groupNameHint => 'Trabalho, Filhos, Academia…';

  @override
  String get cancel => 'Cancelar';

  @override
  String get ok => 'OK';

  @override
  String get noGroup => 'Sem grupo';

  @override
  String get newGroupEllipsis => 'Novo grupo…';

  @override
  String get newGroup => 'Novo grupo';

  @override
  String secondsShort(int n) {
    return '$n s';
  }

  @override
  String minutesShort(int n) {
    return '$n min';
  }

  @override
  String get minutes => 'Minutos';

  @override
  String get ringFor => 'Tocar por';

  @override
  String get seconds => 'Segundos';

  @override
  String get oneSecondLess => '1 segundo a menos';

  @override
  String get oneSecondMore => '1 segundo a mais';

  @override
  String inDays(int d) {
    return 'em ${d}d';
  }

  @override
  String inDaysHours(int d, int h) {
    return 'em ${d}d ${h}h';
  }

  @override
  String inHours(int h) {
    return 'em ${h}h';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return 'em ${h}h ${m}min';
  }

  @override
  String inMins(int m) {
    return 'em ${m}min';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · mudar';
  }

  @override
  String get israel => 'Israel';

  @override
  String get outsideIsrael => 'fora de Israel';

  @override
  String get comingUpHeading => 'EM BREVE';

  @override
  String get lockForShabbat => 'Bloquear o celular no Shabat';

  @override
  String get lockForShabbatHint => 'Do acendimento das velas até a Havdalá, nas festas também';

  @override
  String get ownShabbatAlarmsHeading => 'SEUS ALARMES DE SHABAT';

  @override
  String get addShabbatAlarm => 'Adicionar um alarme de Shabat ou festa';

  @override
  String get readyMadeHeading => 'ALARMES PRONTOS';

  @override
  String bringBackDeleted(int n) {
    return 'Trazer de volta os apagados ($n)';
  }

  @override
  String get presetsHint => 'Toque em um para mudar os horários. Deslize para apagar.';

  @override
  String get lockSentence =>
      'Deixe o celular só com o relógio e seus alarmes, para o Shabat ou uma noite de foco.';

  @override
  String get lockExplain =>
      'Enquanto bloqueado, o Quando? mostra só a hora, o próximo alarme e quando o bloqueio termina. Os alarmes continuam funcionando e nada pode ser mudado até desbloquear.';

  @override
  String get lockNowHeading => 'BLOQUEAR AGORA';

  @override
  String get lockAutoHeading => 'BLOQUEAR AUTOMATICAMENTE';

  @override
  String get shabbatAndFestivalsLong => 'Shabat e festas';

  @override
  String get fromCandleToHavdalah => 'Do acendimento das velas até a Havdalá';

  @override
  String get lockCalendarWord => 'Durante eventos chamados…';

  @override
  String get lockCalendarWordHint => 'ex.: bloquear, prova, foco';

  @override
  String get leaveEmptyForNone => 'Deixe vazio para nenhum';

  @override
  String get connectCalendarsFirst => 'Conecte as agendas primeiro (ícone de agenda)';

  @override
  String get openWhenLockStarts => 'Abrir o Quando? quando um bloqueio começar';

  @override
  String get openWhenLockStartsHint =>
      'Um toque suave de 1 segundo traz o Quando? para a frente para bloquear';

  @override
  String get pinToScreen => 'Fixar o Quando? na tela';

  @override
  String get pinToScreenHint =>
      'Outros apps não abrem enquanto estiver bloqueado. O Android pede confirmação na primeira vez.';

  @override
  String get noLocksComingUp => 'Nenhum bloqueio previsto.';

  @override
  String get leaveLockEarly => 'Para sair antes, segure “Segure para desbloquear” por 3 segundos.';

  @override
  String get locked => 'Bloqueado';

  @override
  String get shabbatShalom => 'Shabat shalom';

  @override
  String get chagSameach => 'Chag sameach';

  @override
  String get unlocksHeading => 'DESBLOQUEIA';

  @override
  String get nowCap => 'Agora';

  @override
  String get nextAlarm => 'Próximo alarme';

  @override
  String get holdToUnlock => 'Segure para desbloquear';

  @override
  String get lockSentenceCalm =>
      'Trave o celular no relógio e nos seus alarmes: para uma prova, uma reunião ou uma noite tranquila.';

  @override
  String get lockCalendarHeading => 'COM SUA AGENDA';

  @override
  String get lockCalendarExplain =>
      'Trave durante um evento, ou de um evento até o próximo que você escolher. Funciona com qualquer agenda escolhida, inclusive compartilhadas.';

  @override
  String get lockAddCalendar => 'Adicionar trava pela agenda';

  @override
  String get lockEditCalendar => 'Trava pela agenda';

  @override
  String get lockDuring => 'Durante um evento';

  @override
  String get lockBetween => 'Entre dois eventos';

  @override
  String get lockStartsAt => 'Eventos chamados…';

  @override
  String get lockStartsAtBetween => 'Começa num evento chamado…';

  @override
  String get lockEndsAt => 'Termina no próximo evento chamado…';

  @override
  String get lockStartHint => 'ex.: prova, foco, academia';

  @override
  String get lockEndHint => 'ex.: em casa';

  @override
  String get lockAnyCalendar => 'Qualquer agenda';

  @override
  String get lockNoMatches => 'Nada nas suas agendas combina ainda.';

  @override
  String get lockNextTimes => 'PRÓXIMAS VEZES';

  @override
  String lockDuringTitle(String a) {
    return 'Durante “$a”';
  }

  @override
  String lockBetweenTitle(String a, String b) {
    return 'De “$a” até o próximo “$b”';
  }

  @override
  String lockShabbatCalendarFound(String name) {
    return '“$name” tem horários de Shabat.';
  }

  @override
  String get lockShabbatFromCalendar => 'Travar do acendimento das velas à Havdalá';

  @override
  String get lockShabbatFromCalendarHint => 'Usa os horários dessa agenda, com velas na tela de trava.';

  @override
  String get lockMoreWays => 'Outras formas de travar';

  @override
  String get lockQuietTime => 'Momento de calma';

  @override
  String nextCandleLightingFrom(String time, String name) {
    return 'Próximo acendimento das velas: $time, de $name';
  }

  @override
  String get calendarAlarm => 'Alarme de agenda';

  @override
  String get connectCalendars => 'Conectar agendas';

  @override
  String get calendarAlarmsHeading => 'ALARMES DE AGENDA';

  @override
  String get calendarNoneYet => 'Nenhum ainda. Comece com este e depois ajuste como quiser:';

  @override
  String get fifteenBeforeEvery => '15 minutos antes de cada evento';

  @override
  String get useTheseCalendarsHeading => 'USAR ESTAS AGENDAS';

  @override
  String get noTimedEvents => 'Nenhum evento com horário nessas agendas.';

  @override
  String get atTheStart => 'no início';

  @override
  String everyForBefore(String every, String span) {
    return 'a cada $every durante $span antes';
  }

  @override
  String spanAfterItEnds(String span) {
    return '$span depois que termina';
  }

  @override
  String get noAlarmsChosen => 'Nenhum alarme escolhido';

  @override
  String get gentleWakeUp => 'Despertar suave';

  @override
  String gentleSummary(int minutes, String sound) {
    return '$minutes min antes · $sound';
  }

  @override
  String get off => 'Desligado';

  @override
  String get gentleSentence =>
      'Um som calmo começa baixinho antes do alarme, para você nunca acordar num susto.';

  @override
  String get gentleExplain =>
      'Ele cresce devagar, tirando você do sono leve, e para logo antes de o alarme tocar.';

  @override
  String get startsBeforeHeading => 'COMEÇA ANTES DO ALARME';

  @override
  String get leadUpSoundHeading => 'SOM DE PREPARAÇÃO';

  @override
  String get listen => 'Ouvir';

  @override
  String get whoRecordedThese => 'Quem gravou estes sons';

  @override
  String get done => 'Pronto';

  @override
  String get soundCredits => 'Créditos dos sons';

  @override
  String yourTimeCity(String city) {
    return 'Seu horário ($city)';
  }

  @override
  String get anotherCity => 'Outra cidade…';

  @override
  String get ringingIn5 => 'Tocando em 5 segundos…';

  @override
  String get alarmSaved => 'Alarme salvo.';

  @override
  String alarmSetFor(String span) {
    return 'Alarme marcado para daqui a $span.';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h h $m min';
  }

  @override
  String get editAlarm => 'Editar alarme';

  @override
  String get previewCaps => 'TESTAR';

  @override
  String get saveCaps => 'SALVAR';

  @override
  String cityTimeForYou(String city, String time) {
    return 'horário de $city · $time para você';
  }

  @override
  String repeatHeading(String repeat) {
    return 'REPETIR · $repeat';
  }

  @override
  String get labelField => 'Nome (lido em voz alta se os alarmes falados estiverem ligados)';

  @override
  String get group => 'Grupo';

  @override
  String ringsForHeading(String span) {
    return 'TOCA POR $span';
  }

  @override
  String useDefault(String value) {
    return 'Usar o padrão ($value)';
  }

  @override
  String get save => 'Salvar';

  @override
  String get sameTime => 'mesmo horário';

  @override
  String get untilYouStopIt => 'Até você parar';

  @override
  String get alarm => 'Alarme';

  @override
  String get once => 'Uma vez';

  @override
  String get everyDay => 'Todo dia';

  @override
  String get weekdays => 'Dias úteis';

  @override
  String get weekends => 'Fins de semana';

  @override
  String timeInCity(String time, String city) {
    return '$time horário de $city';
  }

  @override
  String eventsMatching(String words) {
    return 'Eventos com “$words”';
  }

  @override
  String get everyEvent => 'Todo evento';

  @override
  String get sunrise => 'Nascer do sol';

  @override
  String havdalahEndOf(String day) {
    return 'Havdalá · fim de $day';
  }

  @override
  String get yomTov => 'Yom Tov';

  @override
  String get shabbat => 'Shabat';

  @override
  String get presetCountdown => 'Contagem até o acendimento das velas';

  @override
  String get presetHourly => 'De hora em hora, desde 6 horas antes';

  @override
  String get presetDailyWeek => 'Uma vez por dia, na semana anterior';

  @override
  String get presetSecondNight => 'Velas da segunda noite';

  @override
  String get presetFridayReminder => 'Lembrete 3 horas antes: carregue o celular';

  @override
  String get presetFridayReminderLabel => 'Carregue o celular e marque os alarmes de amanhã';

  @override
  String get presetSunset => 'Pôr do sol, e 15 minutos antes';

  @override
  String get pesach => 'Pessach';

  @override
  String get shavuot => 'Shavuot';

  @override
  String get roshHashanah => 'Rosh Hashaná';

  @override
  String get yomKippur => 'Yom Kipur';

  @override
  String get sukkot => 'Sucot';

  @override
  String get sheminiAtzeret => 'Shemini Atzeret';

  @override
  String get simchatTorah => 'Simchat Torá';

  @override
  String get readyNotifications => 'Mostrar alarmes';

  @override
  String get readyNotificationsWhy => 'Permite que a tela do alarme e o botão Parar apareçam.';

  @override
  String get readyFullScreen => 'Tocar sobre a tela de bloqueio';

  @override
  String get readyFullScreenWhy => 'Mostra o alarme em tela cheia, mesmo com o celular bloqueado.';

  @override
  String get readyExact => 'Tocar no minuto certo';

  @override
  String get readyExactWhy => 'Sem isso, o celular pode tocar os alarmes alguns minutos atrasado.';

  @override
  String get readyBattery => 'Continuar rodando na economia de bateria';

  @override
  String get readyBatteryWhy => 'Impede que a economia de bateria silencie os alarmes à noite.';

  @override
  String get tipXiaomi =>
      'Celulares Xiaomi: em Configurações › Apps › Quando?, ative Início automático e coloque Economia de bateria em Sem restrições.';

  @override
  String get tipSamsung =>
      'Celulares Samsung: em Configurações › Bateria › Limites de uso em segundo plano, confira se o Quando? não está em suspensão.';

  @override
  String get tipHuawei =>
      'Celulares Huawei e Honor: em Configurações › Bateria › Inicialização de apps, coloque o Quando? em Gerenciar manualmente e permita tudo.';

  @override
  String get tipOther =>
      'Neste celular: em Configurações › Bateria, permita que o Quando? rode em segundo plano e desative a otimização para ele.';

  @override
  String get testRing => 'Toque de teste';

  @override
  String get testRingBody => 'O Quando? consegue acordar você';

  @override
  String get ringsIn20 => 'Toca em 20 segundos. Bloqueie o celular agora e espere.';

  @override
  String get readyToRing => 'Pronto para tocar';

  @override
  String get checkingPhone => 'Verificando seu celular…';

  @override
  String get phoneReady => 'Seu celular está pronto para tocar todos os alarmes na hora.';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n itens precisam de ajuste, ou os alarmes podem não tocar.',
      one: '1 item precisa de ajuste, ou os alarmes podem não tocar.',
    );
    return '$_temp0';
  }

  @override
  String get fix => 'Resolver';

  @override
  String get testIn20 => 'Testar: tocar em 20 segundos';

  @override
  String get testIn20Hint =>
      'Bloqueie o celular e deixe-o de lado. Se o alarme tocar em tela cheia, está tudo certo.';

  @override
  String get readyToRingHint => 'Confira se o celular deixa todo alarme tocar na hora';

  @override
  String get connections => 'Conexões';

  @override
  String get timeZoneHeading => 'FUSO HORÁRIO';

  @override
  String get followPhone => 'Seguir o celular';

  @override
  String followPhoneNow(String city) {
    return 'Agora $city. Muda sozinho quando você viaja.';
  }

  @override
  String get zoneFixed => 'Fixo. Os alarmes mantêm este horário mesmo em viagem.';

  @override
  String get shabbatCityHeading => 'CIDADE DO SHABAT';

  @override
  String get inIsraelOneDay => 'Em Israel (um dia de festa)';

  @override
  String candleMinutesHeading(int n) {
    return 'VELAS: $n MINUTOS ANTES DO PÔR DO SOL';
  }

  @override
  String get endOfShabbatHeading => 'FIM DO SHABAT E DAS FESTAS';

  @override
  String get nightfallGeonim => 'Saída das estrelas (Gueonim, 8,5°)';

  @override
  String get rabbeinuTam => '72 minutos após o pôr do sol (Rabeinu Tam)';

  @override
  String get whenAlarmRingsHeading => 'QUANDO UM ALARME TOCA';

  @override
  String get recordOrAddSounds => 'Gravar ou adicionar sons';

  @override
  String get ringsForThisLong => 'Toca por este tempo e depois para sozinho';

  @override
  String get sameFades => 'Mesmas transições para todos os alarmes';

  @override
  String get sameFadesOn => 'Substitui as transições de cada alarme. Cada um mantém seu volume.';

  @override
  String get sameFadesOff => 'Desligado: cada alarme usa as transições definidas em Volume.';

  @override
  String get sayItOutLoud => 'Falar em voz alta';

  @override
  String get sayItOutLoudHint => 'Lê para que é o alarme, ex.: “Acendimento das velas, 15 minutos antes”';

  @override
  String get noSnooze => 'Sem soneca';

  @override
  String snoozeUpTo(int times, int minutes) {
    return 'Soneca até $times× de $minutes min';
  }

  @override
  String get wakeUpCheck => 'Confirmação de despertar';

  @override
  String get wakeUpCheckHint => 'Depois de parar, toca de novo em 3 minutos se você não tocar em “Acordei”';

  @override
  String get solveSum => 'Resolver uma conta para parar';

  @override
  String get provesAwake => 'Prova que você está acordado';

  @override
  String get shabbatNoTasks =>
      'No Shabat e nas festas nada disso vale: os alarmes param sozinhos e nunca pedem para você tocar no celular.';

  @override
  String get testAlarmIn1 => 'Tocar um alarme de teste em 1 minuto';

  @override
  String get timesDisclaimer =>
      'Os horários são calculados no seu celular. Em casos limítrofes, consulte seu rabino ou o calendário da comunidade.';

  @override
  String get recommended => 'Recomendado';

  @override
  String get chooseCity => 'Escolher uma cidade';

  @override
  String get testOnlyOnPhone => 'Alarmes de teste só funcionam no celular.';

  @override
  String get testAlarm => 'Alarme de teste';

  @override
  String get testAlarmBody => 'É assim que seus alarmes vão soar';

  @override
  String get testAlarmIn1Set => 'Alarme de teste em 1 minuto. Pode bloquear o celular.';

  @override
  String get presetGone => 'Este modelo não existe mais.';

  @override
  String get editPreset => 'Editar modelo';

  @override
  String get on => 'Ligado';

  @override
  String get ringsHeading => 'TOCA';

  @override
  String get noTimesYet => 'Nenhum horário ainda. Adicione abaixo.';

  @override
  String get atTheMomentItself => 'Na hora exata';

  @override
  String get remove => 'Remover';

  @override
  String get addATime => 'Adicionar um horário';

  @override
  String get resetPreset => 'Voltar ao original';

  @override
  String get skipOneHint => 'Para pular só um alarme, toque nele em “Alarmes desta semana” na tela inicial.';

  @override
  String get unitMinutes => 'minutos';

  @override
  String get unitHours => 'horas';

  @override
  String get unitDays => 'dias';

  @override
  String get before => 'Antes';

  @override
  String get after => 'Depois';

  @override
  String get oneWeek => '1 semana';

  @override
  String daysShort(int n) {
    return '$n d';
  }

  @override
  String hoursShort(int n) {
    return '$n h';
  }

  @override
  String get howToSearch => 'Como buscar';

  @override
  String get searchHelpWord => 'O título contém “dentist”, maiúsculas ou não';

  @override
  String get searchHelpStar => '* é qualquer sequência de letras: dentist, dentures';

  @override
  String get searchHelpQuestion => '? é uma letra: yoga, toga';

  @override
  String get searchHelpPhrase => 'Esta frase exata';

  @override
  String get searchHelpAnd => 'As duas palavras (AND)';

  @override
  String get searchHelpOr => 'Qualquer uma. | também funciona';

  @override
  String get searchHelpNot => 'Excluir. NOT e ! também funcionam';

  @override
  String get searchHelpBrackets => 'Parênteses agrupam palavras';

  @override
  String get searchHelpEmpty => 'Deixe vazio para tocar em todo evento.';

  @override
  String get customTime => 'Outro tempo';

  @override
  String get other => 'Outro';

  @override
  String get sun => 'Sol';

  @override
  String get calendar => 'Agenda';

  @override
  String get newEventAlarm => 'Novo alarme de evento';

  @override
  String get eventAlarm => 'Alarme de evento';

  @override
  String get findEventsHeading => 'ENCONTRE OS EVENTOS';

  @override
  String get searchEventsHint => 'Buscar: dentista, academia OR yoga, dent*…';

  @override
  String get alsoBuiltInTimes => 'Também horários de Shabat, festas e sol';

  @override
  String get alsoBuiltInTimesHint => 'ex.: “velas*”, “havdalá”, “pôr do sol”';

  @override
  String get allMyCalendars => 'Todas as minhas agendas';

  @override
  String get connectToSearch => 'Conecte suas agendas para buscar nelas';

  @override
  String get searching => 'Buscando…';

  @override
  String get nothingMatches60 => 'Nada encontrado nos próximos 60 dias';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n eventos nos próximos 60 dias',
      one: '1 evento nos próximos 60 dias',
    );
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return 'Próximo: toca às $times para “$title”';
  }

  @override
  String showMoreLeft(int n) {
    return 'Mostrar mais (faltam $n)';
  }

  @override
  String get ringBeforeStartsHeading => 'TOCAR ANTES DE COMEÇAR';

  @override
  String get ringWhenStarts => 'Tocar quando começar';

  @override
  String get repeatBeforeHeading => 'E REPETIR ANTES';

  @override
  String get everyPrefix => 'A cada ';

  @override
  String get offLower => 'desligado';

  @override
  String get forInfix => '  durante ';

  @override
  String get ringAfterEndsHeading => 'TOCAR DEPOIS QUE TERMINAR';

  @override
  String get nameOptional => 'Nome (opcional)';

  @override
  String get toppedUp =>
      'Os alarmes são marcados para os próximos 7 dias e renovados sempre que você abre o Quando?.';

  @override
  String get back => 'Voltar';

  @override
  String get next => 'Avançar';

  @override
  String get stepWhichEvents => 'Quais eventos';

  @override
  String get stepWhenToRing => 'Quando tocar';

  @override
  String get stepHowItRings => 'Como toca';

  @override
  String defaultNamed(String name) {
    return 'Padrão ($name)';
  }

  @override
  String get phoneAlarmSound => 'Som de alarme do celular';

  @override
  String get onlineRadio => 'Rádio online';

  @override
  String songLinkOpens(String app) {
    return 'Link de música · abre no $app';
  }

  @override
  String get builtIn => 'Incluso';

  @override
  String get yourRecording => 'Sua gravação';

  @override
  String get sound => 'Som';

  @override
  String get wakeToOwnSound => 'Acorde com o seu som';

  @override
  String get wakeToOwnSoundHint => 'Sua voz, uma música, Spotify ou rádio ao vivo';

  @override
  String musicAdded(String name) {
    return '$name adicionado. Escolha como som de qualquer alarme.';
  }

  @override
  String get playlists => 'Playlists';

  @override
  String get likedSongs => 'Músicas curtidas';

  @override
  String get noPlaylists => 'Nenhuma playlist ainda.';

  @override
  String get noLikedSongs => 'Nenhuma música curtida ainda.';

  @override
  String get needsMic => 'O Quando? precisa do microfone para gravar.';

  @override
  String recordingN(int n) {
    return 'Gravação $n';
  }

  @override
  String couldNotAddFile(String error) {
    return 'Não foi possível adicionar o arquivo: $error';
  }

  @override
  String get addSongLink => 'Adicionar link de música';

  @override
  String get songLink => 'Link de música';

  @override
  String get songLinkHowTo =>
      'No Spotify, Apple Music, YouTube, YouTube Music ou SoundCloud, toque em Compartilhar, depois em Copiar link, e cole aqui.';

  @override
  String get songNameHint => 'Nome, ex.: Playlist da manhã';

  @override
  String get whenAlarmGoesOffHeading => 'QUANDO O ALARME TOCAR';

  @override
  String get playTheSong => 'Tocar a música';

  @override
  String get ringThenOpen => 'Tocar e depois abrir';

  @override
  String get playTheSongHint =>
      'O app dela abre e toca. Se ficar em silêncio por 10 segundos, o som reserva toca no lugar, para você sempre acordar. Alarmes com tarefa tocam e depois abrem a música.';

  @override
  String get ringThenOpenHint => 'O som reserva toca. Parar abre a música no app dela.';

  @override
  String get playForHeading => 'TOCAR POR';

  @override
  String get pausesAfter =>
      'O Quando? pausa a música depois disso, usando o botão de pausa do próprio celular.';

  @override
  String get backupSoundHeading => 'SOM RESERVA';

  @override
  String get notALink => 'Isso não parece um link.';

  @override
  String songOn(String app) {
    return 'Música no $app';
  }

  @override
  String get theWeb => 'a web';

  @override
  String get pickFromYouTube => 'Escolher do meu YouTube';

  @override
  String get youTubeAndMusic => 'YouTube e YouTube Music';

  @override
  String get youTubeOn => 'Conectado · segure para sair';

  @override
  String get youTubeSignIn => 'Entrar com o Google';

  @override
  String get addSongLinkInstead => 'Adicione um link de música.';

  @override
  String get googleSignInFailed => 'O login no Google não terminou. Tente de novo.';

  @override
  String get myYouTube => 'Meu YouTube';

  @override
  String get spotifyDirectOn => 'Spotify direto está ligado';

  @override
  String get spotifyDirect => 'Spotify direto';

  @override
  String get spotifyDirectOnHint => 'Ligado · toque para desligar';

  @override
  String get spotifyDirectHint => 'Toca a música exata. Precisa do Premium.';

  @override
  String get spotifyComingSoon => 'Em breve · precisa do Premium';

  @override
  String get spotifyFailed =>
      'O Spotify não conectou. Confira se o app do Spotify está instalado, se você entrou na conta e se tem Premium.';

  @override
  String get nameThisSound => 'Dê um nome a este som';

  @override
  String get sounds => 'Sons';

  @override
  String get soundsSentence => 'Acorde com a sua voz, uma música, uma playlist ou rádio ao vivo.';

  @override
  String stopTimer(String time) {
    return 'Parar · $time';
  }

  @override
  String get record => 'Gravar';

  @override
  String get addAFile => 'Adicionar arquivo';

  @override
  String get addSongLinkLong => 'Adicionar link de música (Spotify, Apple Music, YouTube…)';

  @override
  String get musicAppsHeading => 'APPS DE MÚSICA';

  @override
  String get pickFromSpotify => 'Escolher do meu Spotify';

  @override
  String get yourPlaylistsAndLiked => 'Suas playlists e músicas curtidas';

  @override
  String get mySpotify => 'Meu Spotify';

  @override
  String get spotifySignInFailed => 'Não foi possível entrar no Spotify.';

  @override
  String get appleMusicNote =>
      'O login chega com a versão para iPhone. Por enquanto, adicione um link de música.';

  @override
  String noSignInNote(String service) {
    return 'O $service não permite login por outros apps. Adicione um link de música.';
  }

  @override
  String get wakeToRadio => 'Acordar com rádio online';

  @override
  String get soundsExplain =>
      'Grave até 5 minutos, adicione um arquivo, um link de música ou rádio ao vivo. Um som reserva toca se algo falhar.';

  @override
  String get yourSoundsHeading => 'SEUS SONS';

  @override
  String playsIn(String app) {
    return 'Toca no $app';
  }

  @override
  String opensIn(String app) {
    return 'Abre no $app';
  }

  @override
  String forSpan(String span) {
    return 'por $span';
  }

  @override
  String get defaultLabel => 'Padrão';

  @override
  String get radioUnreachable => 'Não foi possível acessar o diretório de rádios. Confira sua conexão.';

  @override
  String get addStreamAddress => 'Adicionar endereço de stream';

  @override
  String get notAStream => 'Isso não parece um endereço de stream (começa com http).';

  @override
  String get anyGenre => 'Qualquer gênero';

  @override
  String get stationName => 'Nome da rádio';

  @override
  String get closeSearch => 'Fechar busca';

  @override
  String get searchByName => 'Buscar por nome';

  @override
  String get anywhere => 'Qualquer lugar';

  @override
  String get noStations => 'Nenhuma rádio encontrada. Tente outro gênero ou país.';

  @override
  String wakeUpTo(String name) {
    return 'Acordar com $name';
  }

  @override
  String get notQuite => 'Quase. Tente de novo.';

  @override
  String shabbatStopsItself(int n) {
    return 'Modo Shabat: para sozinho em $n segundos. Não precisa tocar no celular.';
  }

  @override
  String get solveToSnooze => 'RESOLVA PARA SONECA';

  @override
  String get solveToStop => 'RESOLVA PARA PARAR';

  @override
  String get answer => 'Resposta';

  @override
  String get snooze => 'Soneca';

  @override
  String get stop => 'Parar';

  @override
  String get shakeToSnooze => 'SACUDA PARA SONECA';

  @override
  String get shakeToStop => 'SACUDA PARA PARAR';

  @override
  String get shakeHard => 'Sacuda o celular com força até a barra encher.';

  @override
  String get cantShake => 'Não dá para sacudir? Resolva uma conta';

  @override
  String get pairsToSnooze => 'ACHE OS PARES PARA SONECA';

  @override
  String get pairsToStop => 'ACHE OS PARES PARA PARAR';

  @override
  String get typeToSnooze => 'DIGITE ISTO PARA SONECA';

  @override
  String get typeToStop => 'DIGITE ISTO PARA PARAR';

  @override
  String get scanToSnooze => 'ESCANEIE SEU CÓDIGO PARA SONECA';

  @override
  String get scanToStop => 'ESCANEIE SEU CÓDIGO PARA PARAR';

  @override
  String ringAgainUnless(int n) {
    return 'Vou tocar de novo em $n minutos se você não tocar abaixo.';
  }

  @override
  String get imUp => 'Acordei';

  @override
  String snoozeMin(int n) {
    return 'Soneca $n min';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return 'Soneca $n min · faltam $left';
  }

  @override
  String get noSnoozesLeft => 'Acabaram as sonecas';

  @override
  String get stopThenOpen => 'Parar · e abrir';

  @override
  String get startingSong => 'Iniciando sua música';

  @override
  String wayToStop(String way) {
    return '$way para parar';
  }

  @override
  String wayToSnooze(String way) {
    return '$way para soneca';
  }

  @override
  String ringsForMore(int n) {
    return 'Toca por mais $n segundos';
  }

  @override
  String get leftToRing => 'restantes';

  @override
  String get wayVolumeButtons => 'Botões de volume';

  @override
  String get wayShake => 'Sacudir o celular';

  @override
  String get taskNothing => 'Nada';

  @override
  String get taskSum => 'Resolver uma conta';

  @override
  String get taskShake => 'Sacudir 30 vezes';

  @override
  String get taskMemory => 'Jogo da memória';

  @override
  String get taskPhrase => 'Digitar uma frase';

  @override
  String get taskScan => 'Escanear um código';

  @override
  String get noLimit => 'sem limite';

  @override
  String upToTimes(int n) {
    return 'até $n×';
  }

  @override
  String shorterEachTime(int n) {
    return '$n min a menos a cada vez';
  }

  @override
  String autoSnoozeAfter(int n) {
    return 'soneca automática após $n min';
  }

  @override
  String get card => 'Carta';

  @override
  String get hiddenCard => 'Carta virada';

  @override
  String get phrase1 => 'Estou acordado e o dia é meu';

  @override
  String get phrase2 => 'Se não agora, quando';

  @override
  String get phrase3 => 'Bom dia para mim e para todos que eu amo';

  @override
  String get phrase4 => 'Meus pés estão no chão e eu levantei';

  @override
  String get phrase5 => 'Hoje eu recomeço';

  @override
  String get notQuiteWords => 'Quase, confira cada palavra.';

  @override
  String get typeItHere => 'Digite aqui';

  @override
  String get differentCode => 'Esse é outro código.';

  @override
  String get cameraUnavailable => 'A câmera não está disponível.';

  @override
  String get cantScan => 'Não dá para escanear? Resolva uma conta';

  @override
  String get saveCodeToScan => 'Salvar um código para escanear';

  @override
  String get saveCodeHint =>
      'Aponte a câmera para um código de barras ou QR num lugar até onde você precise andar, como uma caixa na cozinha ou a pasta de dentes no banheiro. Para parar o alarme, você vai escaneá-lo de novo.';

  @override
  String get cameraUnavailableSettings =>
      'A câmera não está disponível. Permita o acesso à câmera nas Configurações.';

  @override
  String gentleToGo(int n) {
    return 'Despertar suave · faltam $n min';
  }

  @override
  String previewBody(String body) {
    return 'Teste · $body';
  }

  @override
  String snoozedBody(String body) {
    return 'Soneca: $body';
  }

  @override
  String get areYouUp => 'Você acordou?';

  @override
  String get tapImUp => 'Toque em “Acordei” para parar';

  @override
  String get volume => 'Volume';

  @override
  String get wakeCheckOn => 'Confirmação ligada';

  @override
  String get stopsAtOnce => 'Para na hora';

  @override
  String get ringsAgainIfNotUp => 'Toca de novo se você não levantar';

  @override
  String get openAppAfter => 'Abrir um app depois';

  @override
  String get noTask => 'Sem tarefa';

  @override
  String get codeSaved => 'Código salvo';

  @override
  String get tapToSaveDifferent => 'Toque para salvar outro';

  @override
  String get controlsHeading => 'CONTROLES';

  @override
  String get onScreen => 'Na tela';

  @override
  String get taskHeading => 'TAREFA';

  @override
  String get none => 'Nenhuma';

  @override
  String get snoozeSentence =>
      'Mais cinco minutinhos? Escolha quanto tempo, quantas vezes e o que é preciso fazer.';

  @override
  String get settingsHeading => 'AJUSTES';

  @override
  String get snoozeTime => 'Tempo de soneca';

  @override
  String get snoozeTimeHint => 'Quanto dura a primeira soneca';

  @override
  String get shortenSnoozes => 'Encurtar as próximas sonecas';

  @override
  String get shortenSnoozesHint => 'Cada soneca depois da primeira fica este tanto mais curta';

  @override
  String get autoSnooze => 'Soneca automática';

  @override
  String get autoSnoozeHint => 'Se você não tocar, entra em soneca sozinho depois de';

  @override
  String get never => 'Nunca';

  @override
  String get snoozeLimit => 'Limite de sonecas';

  @override
  String get snoozeLimitHint => 'Quantas vezes você pode adiar';

  @override
  String get unlimited => 'Sem limite';

  @override
  String get useSnoozeFromSettings => 'Usar a soneca dos Ajustes';

  @override
  String get stopSentence => 'Como você desliga o alarme e o que precisa fazer antes.';

  @override
  String get shabbatNoTask => 'No Shabat e nas festas os alarmes param sozinhos e nunca pedem tarefa.';

  @override
  String get volumeSentence => 'Quão alto toca, e com que suavidade chega lá.';

  @override
  String get openAfterAlarm => 'Abrir depois do alarme';

  @override
  String get pickAnApp => 'Escolher um app';

  @override
  String get orPasteLink => 'Ou cole um link: https://…';

  @override
  String get useThisLink => 'Usar este link';

  @override
  String get noAppsFound => 'Nenhum app encontrado.';

  @override
  String get weather => 'Tempo';

  @override
  String get news => 'Notícias';

  @override
  String get usePhoneVolume => 'Usar o volume de alarme do celular';

  @override
  String get setsPhoneVolume =>
      'Ajusta o volume de alarme do celular enquanto toca e depois volta ao que era.';

  @override
  String get fadeInOff => 'Aumento gradual: desligado, volume total de uma vez';

  @override
  String fadeInOver(String span) {
    return 'Aumenta em $span';
  }

  @override
  String get fadeOutOff => 'Diminuição gradual: desligada';

  @override
  String fadeOutOver(String span) {
    return 'Diminui nos últimos $span';
  }

  @override
  String get fadesExplain =>
      'A diminuição acontece quando o alarme para sozinho. Se as transições forem mais longas que o toque, as duas encolhem para caber.';

  @override
  String get soundSoftChime => 'Sino suave';

  @override
  String get soundMorningRise => 'Manhã nascendo';

  @override
  String get soundClassicBeep => 'Bipe clássico';

  @override
  String get calmCity => 'Manhã tranquila na cidade';

  @override
  String get calmBirds => 'Pássaros ao amanhecer';

  @override
  String get calmWaves => 'Ondas na praia';

  @override
  String get calmRain => 'Chuva fina';

  @override
  String get calmStream => 'Riacho na floresta';

  @override
  String get calmWind => 'Vento suave';

  @override
  String get calmFire => 'Lareira crepitando';

  @override
  String get calmNight => 'Noite de verão';

  @override
  String get publicDomain => 'Domínio público';

  @override
  String get phoneVolume => 'Volume do celular';

  @override
  String fadesIn(String span) {
    return 'aumenta em $span';
  }

  @override
  String fadesOut(String span) {
    return 'diminui em $span';
  }

  @override
  String get noFade => 'sem transição';

  @override
  String minSecShort(int m, int s) {
    return '$m min $s s';
  }

  @override
  String get happensRings => 'Toca';

  @override
  String get happensStopped => 'Você para';

  @override
  String get happensSnoozed => 'Você adia';

  @override
  String get happensAutoStopped => 'Para sozinho';

  @override
  String get eventLower => 'evento';

  @override
  String get appTest => 'Teste do Quando?';

  @override
  String get pushoverConnected => 'O Pushover está conectado';

  @override
  String get webhookConnected => 'O webhook está conectado';

  @override
  String pushoverSaid(int code, String body) {
    return 'O Pushover respondeu $code: $body';
  }

  @override
  String couldNotReachPushover(String error) {
    return 'Não foi possível acessar o Pushover ($error)';
  }

  @override
  String itAnswered(int code) {
    return 'Respondeu $code';
  }

  @override
  String couldNotReachIt(String error) {
    return 'Não foi possível acessar ($error)';
  }

  @override
  String get calendarNotAllowed => 'O acesso à agenda não foi permitido.';

  @override
  String get playlist => 'Playlist';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n músicas', one: '1 música');
    return '$_temp0';
  }

  @override
  String get spotifySaidNo =>
      'O Spotify recusou. No painel do Spotify, marque Web API para o Quando? e adicione sua conta em User Management.';

  @override
  String serviceDidntAnswer(String service, int code) {
    return 'O $service não respondeu ($code).';
  }

  @override
  String get youTubeSaidNo =>
      'O YouTube recusou. Confira se sua conta Google é usuária de teste do projeto Quando.';

  @override
  String get event => 'Evento';

  @override
  String eventEnds(String title) {
    return '$title (fim)';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return '$s sons e $d aparelhos encontrados.';
  }

  @override
  String get sentCheckDevices => 'Enviado. Confira seus outros aparelhos.';

  @override
  String sentTo(String name) {
    return 'Enviado para $name.';
  }

  @override
  String get zapierHowTo =>
      'No Zapier, crie um Zap que comece com “Webhooks by Zapier → Catch Hook” e cole o URL dele aqui.';

  @override
  String get catchHookUrl => 'URL do Catch Hook';

  @override
  String get iftttHowTo =>
      'No IFTTT, crie um applet que comece com “Webhooks → Receive a web request with a JSON payload”. Use o mesmo nome de evento aqui. Sua chave está em ifttt.com/maker_webhooks/settings.';

  @override
  String get eventName => 'Nome do evento';

  @override
  String get webhooksKey => 'Chave de webhooks';

  @override
  String get webhookHowTo => 'O Quando? envia um JSON POST para este endereço.';

  @override
  String get connectionsSentence =>
      'Avise seus outros apps e aparelhos quando um alarme tocar, parar ou entrar em soneca.';

  @override
  String get pushWhenRings => 'Enviar notificação quando um alarme tocar';

  @override
  String get pushWhenRingsHint => 'Para seus outros celulares, tablet, relógio ou computador';

  @override
  String get yourUserKey => 'Sua chave de usuário';

  @override
  String get appToken => 'Token do app';

  @override
  String get soundAndDevicesHeading => 'SOM E APARELHOS';

  @override
  String get loading => 'Carregando…';

  @override
  String get loadFromPushover => 'Carregar do Pushover';

  @override
  String get soundItPlays => 'Som que toca';

  @override
  String get myPushoverDefault => 'Meu padrão do Pushover';

  @override
  String get pushoverOwnSounds =>
      'Seus próprios sons aparecem aqui depois que você os envia em pushover.net/sounds.';

  @override
  String get allMyDevices => 'Todos os meus aparelhos';

  @override
  String get pushoverOnThisPhone =>
      'Instale o app Pushover neste celular também e ele toca aqui com o seu som do Pushover.';

  @override
  String get priority => 'Prioridade';

  @override
  String get priorityNormal => 'Normal';

  @override
  String get priorityHigh => 'Alta: passa pelo horário de silêncio';

  @override
  String get priorityEmergency => 'Emergência: repete até ser confirmada';

  @override
  String get sending => 'Enviando…';

  @override
  String get sendATest => 'Enviar um teste';

  @override
  String get findUserKey => 'Achar minha chave de usuário';

  @override
  String get makeAppToken => 'Criar um token de app';

  @override
  String get webhooksHeading => 'ZAPIER, IFTTT E WEBHOOKS';

  @override
  String get webhooksExplain =>
      'Dispare qualquer coisa quando um alarme tocar ou você pará-lo: acender luzes, registrar a hora em que acordou, mandar mensagem para alguém.';

  @override
  String get sendWhenAlarm => 'Enviar quando o alarme:';

  @override
  String get pauseOnShabbat => 'Pausar no Shabat e nas festas';

  @override
  String get pauseOnShabbatHint => 'Nada é enviado para alarmes entre o acendimento das velas e a Havdalá';

  @override
  String get webhookPayloadNote =>
      'Cada mensagem leva: event (ring, stopped, snoozed, auto_stopped), title, body, time, shabbat e snoozes. As chaves ficam neste celular.';

  @override
  String get today => 'Hoje';

  @override
  String get tomorrow => 'Amanhã';

  @override
  String get notAWebAddress => 'Isso não parece um endereço da web começando com https://';

  @override
  String get language => 'Idioma';

  @override
  String get phoneLanguage => 'Idioma do celular';

  @override
  String get ringQuote => 'Se não agora, quando?';

  @override
  String get ringQuoteBy => 'Hillel';

  @override
  String get quotesTitle => 'Frases sobre o tempo';

  @override
  String get quotesHint =>
      'Escolha de onde elas vêm. Uma para cada parte do dia; toque na frase para ver outra.';

  @override
  String get quotesOff => 'Desligado';

  @override
  String get quoteSongs => 'Músicas';

  @override
  String get quoteMovies => 'Filmes';

  @override
  String get quoteLiterature => 'Livros e poemas';

  @override
  String get quoteTanakh => 'Tanach (Bíblia hebraica)';

  @override
  String get quoteSages => 'Talmud e sábios';

  @override
  String get quoteSpeeches => 'Discursos famosos';

  @override
  String get quotePhilosophy => 'Filósofos';

  @override
  String get quoteProverbs => 'Provérbios e ditados';

  @override
  String get quotesAlso => 'Mostrar também';

  @override
  String get quoteCarnaval => 'Carnaval';

  @override
  String get quoteCarnavalHint => 'Músicas e ditados durante o Carnaval';

  @override
  String get quoteNearMe => 'Perto de mim';

  @override
  String get quoteNearMeHint =>
      'Poetas e datas do lugar onde você está, pelo seu fuso horário e cidade do Shabat';

  @override
  String get quoteSiddur => 'Sidur (livro de rezas)';

  @override
  String weeklyParasha(String name) {
    return 'Porção semanal da Torá: $name';
  }

  @override
  String poweredBy(String name) {
    return 'com tecnologia $name';
  }

  @override
  String get syncTitle => 'Sincronizar meus aparelhos';

  @override
  String get syncHint =>
      'Entre com o Google para manter alarmes e ajustes iguais em todos os seus aparelhos.';

  @override
  String syncOn(String email) {
    return 'Ativada · $email';
  }

  @override
  String get syncWorking => 'Conectando…';

  @override
  String get syncNotAllowed =>
      'Esta conta ainda não pode sincronizar. Se entrou com e-mail, confirme-o primeiro.';

  @override
  String get syncFailed => 'Não deu para conectar. Toque para tentar de novo.';

  @override
  String get syncStop => 'Parar de sincronizar';

  @override
  String get syncNotSetUp => 'A sincronização ainda não está configurada nesta versão.';

  @override
  String get ringTheseAfterAll => 'Tocar estes, afinal';

  @override
  String skipTheseDay(int n) {
    return 'Pular estes $n neste dia';
  }

  @override
  String turnOffNamed(String name) {
    return 'Desligar “$name”';
  }

  @override
  String turnOnNamed(String name) {
    return 'Ligar “$name”';
  }

  @override
  String turnedOffNamed(String name) {
    return '“$name” desligado';
  }

  @override
  String removeTimeFrom(String time, String name) {
    return 'Tirar “$time” de “$name”';
  }

  @override
  String removedTimeFrom(String time, String name) {
    return '“$time” tirado de “$name”';
  }

  @override
  String get moveToGroup => 'Mover para um grupo';

  @override
  String inGroupMove(String group) {
    return 'Em “$group”, mover';
  }

  @override
  String movedToGroup(String group) {
    return 'Movido para “$group”';
  }

  @override
  String deleteNamed(String name) {
    return 'Apagar “$name”';
  }

  @override
  String get signInWithGoogle => 'Entrar com o Google';

  @override
  String get signOut => 'Sair';

  @override
  String get signInWithEmail => 'Entrar com e-mail';

  @override
  String get signIn => 'Entrar';

  @override
  String get createAccount => 'Criar conta';

  @override
  String get haveAccount => 'Já tenho conta';

  @override
  String get forgotPassword => 'Esqueci a senha';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Senha';

  @override
  String get passwordResetSent => 'Enviamos um link para você criar uma nova senha.';

  @override
  String emailCheckInbox(String email) {
    return 'Enviamos um link para $email. Abra e depois volte e toque em “Já confirmei”.';
  }

  @override
  String get emailConfirmed => 'Já confirmei';

  @override
  String get emailNotYet => 'Ainda não confirmado. Abra o link do e-mail primeiro.';

  @override
  String get emailSendAgain => 'Reenviar o e-mail';

  @override
  String get emailSentAgain => 'Enviado. Veja a caixa de entrada e o spam.';

  @override
  String get emailInvalid => 'Isso não parece um endereço de e-mail.';

  @override
  String get emailWrong => 'E-mail ou senha incorretos.';

  @override
  String get emailInUse =>
      'Já existe uma conta com este e-mail. Entre com ela, ou use o Google se ela foi criada pelo Google.';

  @override
  String get passwordWeak => 'Escolha uma senha com pelo menos 6 caracteres.';

  @override
  String get emailNotSwitchedOn => 'O login por e-mail ainda não está ativado.';

  @override
  String get tooManyTries => 'Tentativas demais. Espere alguns minutos.';

  @override
  String get spotifyLibrary => 'Spotify';

  @override
  String get spotifyLibrarySignIn => 'Playlists, músicas curtidas e busca';

  @override
  String get spotifyLibraryOn => 'Conectado · segure para sair';

  @override
  String spotifyLoginError(String reason) {
    return 'O login no Spotify não funcionou: $reason';
  }

  @override
  String googleSignInError(String reason) {
    return 'O login no Google não funcionou: $reason';
  }

  @override
  String get searchSongsHint => 'Buscar músicas, artistas, playlists';

  @override
  String nothingFound(String query) {
    return 'Nada encontrado para “$query”.';
  }

  @override
  String get deliveryTitle => 'Como avisar';

  @override
  String get deliveryLocal => 'Áudio local';

  @override
  String get deliveryBoth => 'Ambos';

  @override
  String get deliveryConnect => 'Conectar Pushover';

  @override
  String get deliveryLoadFailed => 'Não foi possível carregar sons e dispositivos. Tente novamente.';

  @override
  String get deliveryBothHint => 'O áudio local toca mesmo se o Pushover falhar.';

  @override
  String get deliveryPushHint => 'Só Pushover. Este dispositivo precisa estar conectado na hora.';

  @override
  String get deliveryFallback => 'O áudio local é mantido se o Pushover estiver desconectado ou pausado.';

  @override
  String get deliveryReset => 'Usar ajustes existentes';

  @override
  String get beforeShabbat => 'Antes do Shabbat';

  @override
  String get preparationReminders => 'Lembretes de preparação';

  @override
  String get skipThisWeek => 'Pular esta semana';

  @override
  String get restoreThisWeek => 'Restaurar esta semana';

  @override
  String get allAlarms => 'Todos os alarmes';

  @override
  String get timesAndSound => 'Horários e som';

  @override
  String get changeCity => 'Mudar cidade';

  @override
  String get useMyLocation => 'Usar minha localização';

  @override
  String get locationUnavailable =>
      'Não foi possível obter a localização agora. Tente novamente ou escolha uma cidade.';

  @override
  String get locationReview => 'Confirmar esta localização';

  @override
  String get locationDeviceOnly =>
      'Esta localização fica apenas neste dispositivo. Confira o fuso horário e a opção Israel antes de usar os horários.';

  @override
  String timesIn(String city, String zone) {
    return '$city · $zone · horário da cidade';
  }

  @override
  String get preparationOff =>
      'Os lembretes de preparação estão desligados. Havdalá e alarmes comuns não mudam.';

  @override
  String get preparationSkipped =>
      'Os lembretes de preparação foram pulados nesta semana. Seus ajustes semanais foram mantidos.';

  @override
  String get shabbatControls => 'Controles do Shabbat';

  @override
  String get duringAfterShabbat => 'Durante / depois do Shabbat';

  @override
  String locationCoordinates(String latitude, String longitude) {
    return 'Latitude $latitude · longitude $longitude';
  }

  @override
  String get currentLocation => 'Localização atual';

  @override
  String get testPushoverSound => 'Testar som no Pushover';

  @override
  String get pushoverSoundTestHint =>
      'Toca o som escolhido nos seus dispositivos Pushover selecionados. Silêncio e horários silenciosos continuam valendo.';

  @override
  String get pushoverShareDevices => 'Compartilhar credenciais com meus dispositivos';

  @override
  String get pushoverShareHint =>
      'Sua chave de usuário e token do Pushover podem acompanhar sua conta no Quando? e no Matai?.';

  @override
  String get pushoverShareQueued => 'Credenciais na fila de sincronização dos seus dispositivos conectados.';

  @override
  String get pushoverShareSignIn =>
      'Entre na mesma conta do app em cada dispositivo para compartilhar as credenciais Pushover.';

  @override
  String get smartHomeHeading => 'Casa inteligente';

  @override
  String get smartHomeHint =>
      'Execute cenas Tuya diretamente ou conecte suas automações do Home Assistant e Node-RED.';

  @override
  String get shareServices => 'Compartilhar conexões dos serviços';

  @override
  String get shareServicesHint =>
      'Use a mesma conta do app nos seus dispositivos para compartilhar Pushover, Tuya, biblioteca Spotify e automações. YouTube e permissões do aparelho ainda podem exigir aprovação em cada dispositivo.';

  @override
  String get tuyaSetupHint =>
      'Use seu projeto Tuya vinculado. Informe o centro de dados, Access ID, Access Secret e o UID em Link App Account. Não precisa de Home Assistant.';

  @override
  String get tuyaDataCenter => 'Centro de dados';

  @override
  String get tuyaUserId => 'UID da conta vinculada';

  @override
  String get tuyaAccessId => 'Access ID / Client ID';

  @override
  String get tuyaAccessSecret => 'Access Secret / Client Secret';

  @override
  String get tuyaLoadScenes => 'Carregar cenas';

  @override
  String get tuyaNoScenes =>
      'Nenhuma cena Tap-to-Run disponível. Confira a conta vinculada, o centro de dados e as permissões da API de cenas.';

  @override
  String get tuyaRunNow => 'Executar cena agora';

  @override
  String get tuyaRunConfirm => 'Executar esta cena nos seus dispositivos Tuya agora?';

  @override
  String get tuyaSent => 'Tuya aceitou o comando da cena. Confira seus dispositivos.';

  @override
  String get tuyaFailed =>
      'Tuya não concluiu a solicitação. Confira as permissões, o centro de dados e a assinatura do projeto. Erro:';

  @override
  String get tuyaAlarmScene => 'Cena Tuya quando este alarme tocar';

  @override
  String get homeAssistantHowTo =>
      'Crie uma automação no Home Assistant com gatilho Webhook aceitando POST e JSON. Cole a URL aqui. Use o evento do alarme (ring, stopped, snoozed ou auto_stopped) para escolher as ações. Em novos aparelhos, esta conexão começa desligada.';

  @override
  String get nodeRedHowTo =>
      'Use um nó HTTP In do Node-RED aceitando POST, seguido da sua automação e de um nó HTTP Response. Cole o endereço aqui. Aceita hubs HTTP locais e endereços HTTPS.';

  @override
  String get smartHomeConnect => 'Conectar um serviço de casa inteligente';

  @override
  String get automationTestHint => 'O teste executa a automação conectada imediatamente.';

  @override
  String get smartHomeDeviceOn => 'Executar ações de casa inteligente neste aparelho';

  @override
  String get smartHomeDeviceHint =>
      'Escolha um aparelho para executar suas automações. As conexões são compartilhadas; este controle fica neste aparelho.';

  @override
  String get smartHomeDeviceOff =>
      'As ações de alarme estão desligadas neste aparelho. Ative em Conexões; os testes manuais de cenas continuam funcionando.';

  @override
  String get homeDisplay => 'Tela inicial';

  @override
  String get skyDay => 'Dia';

  @override
  String get skyDayNight => 'Dia + noite';

  @override
  String get showMoonPhase => 'Fase da lua';

  @override
  String get weatherLabel => 'Clima';

  @override
  String get skyLabel => 'Céu';

  @override
  String get weatherSwipeHint => 'Deslize entre céu e clima';

  @override
  String get parashaHeading => 'Parashá da semana';

  @override
  String get dailyStudyHeading => 'Estudo diário';

  @override
  String get courseDaf => 'Daf Yomi';

  @override
  String get courseRambam1 => 'Rambam · 1 capítulo/dia';

  @override
  String get courseRambam3 => 'Rambam · 3 capítulos/dia';

  @override
  String get courseMitzvot => 'Sefer HaMitzvot';

  @override
  String get courseMishnah => 'Mishná Yomit';

  @override
  String get courseNach => 'Nach Yomi';

  @override
  String get moonriseLabel => 'Nascer da lua';

  @override
  String get moonsetLabel => 'Pôr da lua';

  @override
  String get nightfallLabel => 'Anoitecer';

  @override
  String get moonAlwaysUp => 'Lua acima do horizonte o dia todo';

  @override
  String get moonAlwaysDown => 'Lua abaixo do horizonte o dia todo';

  @override
  String get noRiseToday => 'Não nasce hoje';

  @override
  String get noSetToday => 'Não se põe hoje';

  @override
  String get moonNew => 'Lua nova';

  @override
  String get moonWaxingCrescent => 'Lua crescente';

  @override
  String get moonFirstQuarter => 'Quarto crescente';

  @override
  String get moonWaxingGibbous => 'Gibosa crescente';

  @override
  String get moonFull => 'Lua cheia';

  @override
  String get moonWaningGibbous => 'Gibosa minguante';

  @override
  String get moonLastQuarter => 'Quarto minguante';

  @override
  String get moonWaningCrescent => 'Lua minguante';

  @override
  String get moonIlluminated => 'iluminada';

  @override
  String get weatherClear => 'Céu limpo';

  @override
  String get weatherClouds => 'Nublado';

  @override
  String get weatherRain => 'Chuva';

  @override
  String get weatherSnow => 'Neve / neve com chuva';

  @override
  String get weatherFog => 'Neblina';

  @override
  String get weatherThunder => 'Trovoadas';

  @override
  String get weatherUnavailable => 'O clima está temporariamente indisponível';

  @override
  String get weatherCached => 'Previsão salva';

  @override
  String get weatherUpdated => 'Atualizado';

  @override
  String get weatherForecast => 'Previsão';

  @override
  String get weatherThunderExpected => 'Trovoadas previstas';

  @override
  String get learningUnavailable => 'Conecte-se para carregar o calendário de estudos deste mês';

  @override
  String get festivalReading => 'Leitura de Torá da festa';

  @override
  String get learningCalendarSource => 'Calendário de estudos · Hebcal · CC BY 4.0';

  @override
  String get weatherSource => 'Previsão · MET Norway · CC BY 4.0';

  @override
  String get weatherConsent => 'Clima da cidade selecionada. Usa coordenadas arredondadas com MET Norway.';

  @override
  String get learningConsent =>
      'Os calendários de Rambam e outros estudos são carregados do Hebcal e salvos para uso offline.';

  @override
  String get homeRefresh => 'Atualizar';

  @override
  String get skyTimezone => 'Meu fuso horário';

  @override
  String get skyShabbat => 'Cidade do Shabat';

  @override
  String get skyReferenceCity => 'Cidade de referência do fuso';

  @override
  String get skyChooseCity => 'Escolher cidade para o céu';

  @override
  String get skyCityExplain =>
      'Sol e Lua usam as coordenadas desta cidade. Sua cidade do Shabat e o fuso dos alarmes permanecem como escolhidos.';

  @override
  String get skySun => 'Sol hoje';

  @override
  String get skyMoon => 'Lua hoje';

  @override
  String get moonAboveHorizon => 'Lua acima do horizonte';

  @override
  String get moonBelowHorizon => 'Lua abaixo do horizonte';

  @override
  String get moonNextNew => 'Próxima lua nova';

  @override
  String get moonNextFull => 'Próxima lua cheia';

  @override
  String get locationServicesOff =>
      'Os Serviços de Localização estão desativados. Ative-os nos Ajustes ou escolha uma cidade.';

  @override
  String get locationDenied =>
      'O acesso à localização foi negado. Permita-o nos Ajustes ou escolha uma cidade.';

  @override
  String get locationTimedOut =>
      'Ainda não foi possível obter a localização. No Mac, mantenha o Wi-Fi ativado e tente novamente, ou escolha uma cidade.';

  @override
  String get locationTimeZoneUnavailable =>
      'Use uma cidade no fuso selecionado ou siga o fuso do dispositivo antes de usar a localização.';

  @override
  String get locationSettings => 'Abrir ajustes de localização';

  @override
  String get locationLooking => 'Obtendo a localização…';

  @override
  String get skyMoonDisplay => 'Mostrar Lua: nascer, pôr e fase';

  @override
  String get tuyaConsumerPending =>
      'O login da conta ainda não está disponível nesta versão. Se você já tem um projeto de desenvolvedor Tuya, use a configuração avançada.';

  @override
  String get tuyaAdvanced => 'Configuração avançada';

  @override
  String get tuyaSignInTitle => 'Entrar com sua conta Smart Life';

  @override
  String get tuyaSignInHint =>
      'Use o mesmo país, e-mail ou telefone e senha do app Smart Life ou Tuya Smart. A conta já precisa estar vinculada ao seu projeto Tuya. A senha vai só para a Tuya e nunca é salva.';

  @override
  String get tuyaCountryCode => 'Código do país (Brasil 55, EUA 1)';

  @override
  String get tuyaAccount => 'E-mail ou telefone do Smart Life';

  @override
  String get tuyaPassword => 'Senha do Smart Life';

  @override
  String get tuyaSignIn => 'Entrar e carregar cenas';

  @override
  String get tuyaRelayUrl => 'Endereço do relay Tuya do Quando (https)';

  @override
  String get tuyaRelayHint =>
      'Use o país, o e-mail ou telefone e a senha da sua conta Smart Life ou Tuya Smart. Eles vão uma vez ao relay Tuya do Quando e não são salvos. Você precisa estar conectado à sua conta Quando.';

  @override
  String get tuyaGoogleHint =>
      'Entra no Smart Life com Google ou Apple? No Smart Life, toque em “Esqueci a senha” para criar uma senha e use-a aqui.';

  @override
  String get tuyaLinked => 'Conta Smart Life vinculada';

  @override
  String get tuyaUnlink => 'Desvincular';

  @override
  String get tuyaNeedsAccount => 'Primeiro entre na sua conta Quando em Ajustes.';

  @override
  String get roshHodeshHeading => 'Rosh Hodesh';

  @override
  String get roshHodeshExplain =>
      'Mostrar na tela inicial o próximo início do mês hebraico, de um ou dois dias.';

  @override
  String get roshHodeshNext => 'Próximo Rosh Hodesh';

  @override
  String get roshHodeshBegins => 'Começa ao pôr do sol de';

  @override
  String get openParashaSefaria => 'Ler esta porção da Torá no Sefaria';

  @override
  String get skyMyLocation => 'Minha localização';

  @override
  String get skyLocationLocalTimes =>
      'Os horários do céu usam o fuso desta localização. O fuso dos alarmes e a cidade de Shabat permanecem iguais. Salvo só neste aparelho.';

  @override
  String get musicRingDurationHint =>
      'A reprodução segue a duração definida neste alarme e para com Parar ou Soneca.';

  @override
  String get musicBackupPlaying => 'Não foi possível iniciar a música. O som local do alarme está tocando.';

  @override
  String desktopMusicConnect(String service) {
    return 'Conectar o app $service';
  }

  @override
  String desktopMusicOn(String service) {
    return 'Conectado ao $service · segure para desconectar';
  }

  @override
  String get musicSongs => 'Músicas';

  @override
  String get noMusicSongs => 'Nenhuma música encontrada na biblioteca do Música.';

  @override
  String serviceConnectUnavailable(String service) {
    return 'Adicione um link do $service · abre depois do alarme';
  }

  @override
  String get soundCloudWidgetNote => 'Adicione um link público';

  @override
  String get youtubePlayerHint =>
      'O YouTube reproduz vídeo em um player visível. Se ele ficar oculto ou não puder tocar, o alarme local continua.';

  @override
  String get musicPreviewFailed =>
      'Não foi possível tocar este som. Verifique sua conexão ou tente outra faixa ou estação.';

  @override
  String get skyMoonPhase => 'Fase da lua';

  @override
  String get skyMoonDetailsDisplay => 'Adicionar página da fase da lua';

  @override
  String get skyMoonDetailsHint => 'Deslize até ela, ou toque no cartão da Lua a qualquer momento';

  @override
  String get moonRises => 'Nasce';

  @override
  String get moonSets => 'Se põe';

  @override
  String moonLunarDay(int day) {
    return 'Dia $day de 29,5 deste mês lunar';
  }

  @override
  String get moonDetailsOpen => 'Abrir fase da lua';

  @override
  String get musicPlaylists => 'Playlists de música';

  @override
  String get videoPlaylists => 'Playlists de vídeo';

  @override
  String get likedVideos => 'Vídeos curtidos';

  @override
  String get wholePlaylist => 'Acordar com a playlist inteira';

  @override
  String get noSongsInPlaylist => 'Nenhuma música que dê para tocar aqui.';

  @override
  String get hebrewNamesHeading => 'Grafia da parashá e dos meses';

  @override
  String get hebrewNamesIsraeli => 'Israelense';

  @override
  String get hebrewNamesAshkenazi => 'Asquenazita';

  @override
  String pickFromService(String service) {
    return 'Escolher do meu $service';
  }

  @override
  String get weatherTonight => 'Hoje à noite';

  @override
  String get weatherTomorrowMorning => 'Amanhã de manhã';

  @override
  String weatherUntilAbout(String time) {
    return 'até por volta das $time';
  }

  @override
  String get weatherSunBehindClouds => 'Sol atrás das nuvens';

  @override
  String get keysLockTitle => 'Chaves nos seus aparelhos';

  @override
  String get keysLockOff =>
      'Suas chaves de serviço ficam neste aparelho. Escolha uma senha de sincronização para enviá-las, criptografadas, aos seus outros aparelhos.';

  @override
  String get keysLockOn =>
      'Suas chaves de serviço são criptografadas com sua senha de sincronização antes de sair deste aparelho. Ninguém mais, nem o Google, consegue lê-las.';

  @override
  String get keysLockWaiting =>
      'Chaves do seu outro aparelho chegaram aqui, trancadas. Digite sua senha de sincronização para abri-las.';

  @override
  String get keysSetPassphrase => 'Escolher senha';

  @override
  String get keysChangePassphrase => 'Trocar senha';

  @override
  String get keysUnlock => 'Destrancar chaves';

  @override
  String get keysStartOver => 'Esqueceu? Recomeçar';

  @override
  String get keysStartOverHint =>
      'Recomeçar envia as chaves deste aparelho com uma senha nova. Seus outros aparelhos vão pedir a nova.';

  @override
  String get keysPassphrase => 'Senha de sincronização';

  @override
  String get keysPassphraseAgain => 'Digite de novo';

  @override
  String keysPassphraseShort(int count) {
    return 'Use pelo menos $count caracteres.';
  }

  @override
  String get keysPassphraseMismatch => 'As duas não são iguais.';

  @override
  String get keysPassphraseWrong => 'Essa senha não abre estas chaves.';

  @override
  String get keysPassphraseNote =>
      'Anote: se esquecer, ninguém consegue recuperá-la, e você vai digitar suas chaves de novo.';

  @override
  String get keysShareNeedsPassphrase =>
      'Escolha primeiro uma senha de sincronização, em Chaves nos seus aparelhos.';

  @override
  String get settingsAlarmDefaults => 'Padrões dos alarmes';

  @override
  String get settingsPlacesTime => 'Lugares e horário';

  @override
  String get settingsLook => 'Aparência, idioma e frases';

  @override
  String get settingsAbout => 'Sobre';

  @override
  String get defaultForNewAlarms => 'Padrão para novos alarmes';

  @override
  String get preview => 'Pré-visualizar';

  @override
  String atClock(String time) {
    return 'às $time';
  }

  @override
  String get connectACalendar => 'Conectar uma agenda';

  @override
  String get newFromReadyMade => 'De um modelo pronto';

  @override
  String get newFromReadyMadeHint => 'Nascer do sol, pôr do sol e outros alarmes já prontos para você';

  @override
  String get calendarSourcesIntro =>
      'O Quando? pode tocar antes e depois dos eventos das suas agendas. Escolha de onde eles vêm.';

  @override
  String get deviceCalendarsHeading => 'NESTE APARELHO';

  @override
  String get deviceCalendarsTitle => 'App de agenda deste aparelho';

  @override
  String get deviceCalendarsHint =>
      'Todas as contas dele: Google, Samsung, Outlook, iCloud e agendas guardadas só aqui.';

  @override
  String get googleCalendarHeading => 'GOOGLE AGENDA';

  @override
  String get googleCalendarSignIn =>
      'Entre com o Google para ler suas agendas direto do Google, mesmo se sua conta Google não estiver neste aparelho.';

  @override
  String googleCalendarSignedIn(String email) {
    return 'Conectado como $email';
  }

  @override
  String get googleCalendarSignOut => 'Sair';

  @override
  String get googleCalendarNotHere =>
      'O login com Google ainda não está disponível neste aparelho. Adicione sua conta Google nos ajustes do aparelho (Calendário › Contas) e as agendas dela aparecem neste aparelho.';

  @override
  String get googleCalendarUnreachable =>
      'Não deu para acessar o Google Agenda agora. Os alarmes já marcados a partir dele continuam tocando.';

  @override
  String get googleCalendarTwiceHint =>
      'Agendas que este aparelho já mostra da mesma conta Google começam desligadas, para nada tocar duas vezes.';

  @override
  String get timersTitle => 'Cronômetros';

  @override
  String get timerStopwatch => 'Cronômetro';

  @override
  String get timerCountdown => 'Timer';

  @override
  String get timerSequence => 'Largada';

  @override
  String get timerStopwatchSub => 'Conta para cima, com voltas';

  @override
  String get timerCountdownSub => 'Conta para baixo, toca no zero';

  @override
  String get timerSequenceSub => 'Largada e marcas faladas';

  @override
  String get timerStart => 'Iniciar';

  @override
  String get timerPause => 'Pausar';

  @override
  String get timerResume => 'Continuar';

  @override
  String get timerReset => 'Zerar';

  @override
  String get timerLap => 'Volta';

  @override
  String get timerTimesUp => 'Acabou o tempo';

  @override
  String get timerSetTime => 'Defina o tempo';

  @override
  String get timerMinutes => 'Minutos';

  @override
  String get timerSeconds => 'Segundos';

  @override
  String get seqOnYourMarks => 'Atenção';

  @override
  String get seqGetSet => 'Preparar';

  @override
  String get seqGo => 'Já!';

  @override
  String get seqFinish => 'Tempo!';

  @override
  String get seqReady => 'Pronto';

  @override
  String get seqSettings => 'Ajustes';

  @override
  String get seqStartCalls => 'Chamadas antes da largada';

  @override
  String get seqStartCallsHelp => 'Faladas antes do Já, contando para trás a partir da largada.';

  @override
  String seqCallBefore(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n segundos antes',
      one: '1 segundo antes',
    );
    return '$_temp0';
  }

  @override
  String get seqAddCall => 'Adicionar chamada';

  @override
  String get seqCallText => 'O que falar';

  @override
  String get seqGoText => 'Na largada, falar';

  @override
  String get seqFinishText => 'No fim, falar';

  @override
  String get seqLength => 'Duração';

  @override
  String get seqNoLimit => 'Sem limite';

  @override
  String get seqSayEvery => 'Falar o tempo a cada';

  @override
  String get seqOff => 'Desligado';

  @override
  String seqEverySeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n segundos', one: '1 segundo');
    return '$_temp0';
  }

  @override
  String seqEveryMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n minutos', one: '1 minuto');
    return '$_temp0';
  }

  @override
  String get seqFinalCount => 'Contagem regressiva dos últimos';

  @override
  String get seqMarks => 'Suas marcas';

  @override
  String get seqAddMark => 'Adicionar marca';

  @override
  String seqMarkAt(String time) {
    return 'Em $time';
  }

  @override
  String get seqSpeak => 'Falar em voz alta';

  @override
  String get seqBeeps => 'Bips e vibração';

  @override
  String get seqSayRemaining => 'Falar o tempo que falta, não o que passou';

  @override
  String get seqPresets => 'Modelos';

  @override
  String get seqPresetRace => 'Largada de corrida';

  @override
  String get seqPresetSprint => 'Esforço de 30 s';

  @override
  String get seqPresetRound => 'Rodada de 1 min';

  @override
  String get seqHintNoLimit => 'Depois do Já ele conta para cima até você parar.';

  @override
  String get seqHintLength => 'Depois do Já ele conta para baixo até zero.';

  @override
  String get seqWords => 'Palavras';

  @override
  String get homeEdit => 'Organizar o início';

  @override
  String get homeEditHint => 'Arraste a alça para mover um cartão, recolha-o ou mude o tamanho.';

  @override
  String get homeReset => 'Restaurar layout';

  @override
  String get homeMove => 'Mover';

  @override
  String get homeExpand => 'Mostrar';

  @override
  String get homeCollapse => 'Recolher';

  @override
  String get homeSize => 'Tamanho';

  @override
  String get homeBlockClock => 'RELÓGIO';

  @override
  String get homeBlockSky => 'SOL, LUA E TEMPO';

  @override
  String get homeBlockQuick => 'ALARMES RÁPIDOS';

  @override
  String get homeBlockShabbat => 'SHABAT E FESTAS';

  @override
  String get homePlaceTitle => 'Cidade do céu';

  @override
  String nextAlarmLine(String title, String time) {
    return 'Próximo alarme · $title $time';
  }

  @override
  String get showAllAlarms => 'Mostrar todos os dias';

  @override
  String get noAlarmsThatDay => 'Nada toca neste dia';

  @override
  String get homeClockSize => 'Relógio na tela inicial';

  @override
  String get sizeSmall => 'Pequeno';

  @override
  String get sizeMedium => 'Médio';

  @override
  String get sizeLarge => 'Grande';

  @override
  String get homeLayout => 'Layout da tela inicial';

  @override
  String get homeLayoutClassic => 'Clássico';

  @override
  String get homeLayoutCards => 'Cartões';

  @override
  String get homeCardsHint =>
      'Arraste um cartão para movê-lo. Arraste a borda ou o canto para redimensionar, ou escolha um tamanho.';

  @override
  String get homeAddCard => 'Adicionar cartão';

  @override
  String get homeOnHome => 'Na tela';

  @override
  String get homeRemoveCard => 'Remover';

  @override
  String get cardNext => 'Próximo alarme';

  @override
  String get cardClock => 'Relógio e data';

  @override
  String get cardSky => 'Sol, lua e clima';

  @override
  String get cardMoon => 'Lua';

  @override
  String get cardWeather => 'Clima';

  @override
  String get cardAlarms => 'Seus alarmes';

  @override
  String get cardQuick => 'Alarmes rápidos';

  @override
  String get cardTools => 'Cronômetro, timer e preparar';

  @override
  String get cardWorld => 'Relógios mundiais';

  @override
  String get cardWeek => 'Esta semana';

  @override
  String get cardShabbat => 'Shabat e feriados';

  @override
  String get ringAtEventReminders => 'Tocar nos lembretes do próprio evento';

  @override
  String get ringAtEventRemindersHint =>
      'Os lembretes do seu app de agenda tocam aqui como alarmes altos, com o som deste alarme.';

  @override
  String get atEventReminders => 'nos lembretes do evento';

  @override
  String get everyEventReminderLoud => 'Tocar alto nos lembretes de todo evento';

  @override
  String get loudNotificationsHeading => 'NOTIFICAÇÕES DE AGENDA ALTAS';

  @override
  String get loudNotificationsTitle => 'Deixar as notificações da agenda altas';

  @override
  String get loudNotificationsHint =>
      'Quando um app de agenda mostra um lembrete, o Quando? toca como alarme, mesmo com o celular no silencioso.';

  @override
  String get loudNotificationsDisclosureTitle => 'Permitir que o Quando? leia notificações da agenda?';

  @override
  String get loudNotificationsDisclosure =>
      'Para tocar seus lembretes de agenda em voz alta, o Quando? precisa de acesso às notificações. Ele só olha as notificações dos apps de agenda que você escolher, lê o título e o texto neste celular para mostrar no alarme e nunca os guarda nem envia para lugar nenhum. Você pode desligar quando quiser.';

  @override
  String get loudNotificationsAgree => 'Concordar e continuar';

  @override
  String get loudNotificationsNoAccess =>
      'O acesso às notificações está desligado. Ative o Quando? na lista que abrir.';

  @override
  String get loudNotificationsAllow => 'Permitir';

  @override
  String get loudNotificationsNoApps => 'Nenhum app de agenda compatível encontrado neste celular.';

  @override
  String get loudNotificationsTwiceNote =>
      'Eventos que já têm um alarme de agenda do Quando? tocam só uma vez.';

  @override
  String get loudNotificationsShabbatNote => 'Silencioso durante o Shabat e as festas.';

  @override
  String get busyMode => 'Modo ocupado';

  @override
  String get busyModeSubtitle => 'Não Perturbe e respostas automáticas enquanto você está ocupado';

  @override
  String get busyIntro =>
      'Enquanto você está ocupado, o Quando? pode silenciar o celular e responder mensagens por você. Os alarmes continuam tocando.';

  @override
  String get busyIosFocus =>
      'No iPhone e no iPad, apps não podem ligar o Foco nem responder mensagens. No app Atalhos, crie uma automação \"Quando o Quando? abrir\" ou em um horário que ligue um Foco, e configure o Foco para responder automaticamente.';

  @override
  String get busyWhileHeading => 'ENQUANTO VOCÊ ESTÁ OCUPADO';

  @override
  String get busyDnd => 'Não Perturbe';

  @override
  String get busyDndHint =>
      'Só prioridade: chamadas e mensagens ficam em silêncio, alarmes continuam tocando. Volta ao normal no fim.';

  @override
  String get busyDndNoAccess => 'O Quando? ainda não pode mudar o Não Perturbe.';

  @override
  String get busyReplies => 'Responder mensagens';

  @override
  String get busyRepliesHint =>
      'Uma vez por pessoa, com o seu texto, pelo botão Responder do próprio app. Só Android.';

  @override
  String get busyRepliesDisclosureTitle => 'Permitir que o Quando? responda mensagens?';

  @override
  String get busyRepliesDisclosure =>
      'Para responder por você, o Quando? precisa de acesso às notificações. Só enquanto você está ocupado, ele olha as notificações de mensagens dos apps que você escolher, lê o nome de quem enviou neste celular e envia seu texto uma vez pelo botão Responder do próprio app. As mensagens nunca são guardadas nem enviadas a outro lugar. Grupos ficam de fora, a menos que você permita.';

  @override
  String get busyReplyText => 'Sua resposta';

  @override
  String busyReplyTextHint(String until) {
    return '$until vira o horário em que o modo ocupado termina.';
  }

  @override
  String busyReplyDefault(String until) {
    return 'Estou ocupado agora e respondo depois das $until.';
  }

  @override
  String get busyGroups => 'Responder também em grupos';

  @override
  String get busyGroupsHint => 'Desligado: grupos nunca recebem resposta.';

  @override
  String get busyRepliesOnShabbat => 'Responder durante o Shabat e as festas';

  @override
  String get busyAskRabbi => 'Desligado por padrão. Pergunte ao seu rabino antes de ligar no Shabat.';

  @override
  String get busyWhenHeading => 'QUANDO VOCÊ ESTÁ OCUPADO';

  @override
  String get busyWhenHint =>
      'Ligue \"Ocupado durante estes eventos\" num alarme de agenda, ou \"Ocupado depois de tocar\" num alarme.';

  @override
  String get busyDuringLock => 'Ocupado enquanto o modo bloqueio está ligado';

  @override
  String get busyNoneComing => 'Nada ocupado nos próximos 7 dias.';

  @override
  String get busyDuringEvents => 'Ocupado durante estes eventos';

  @override
  String get busyDuringEventsHint => 'Modo ocupado do início ao fim de cada evento.';

  @override
  String get busySettings => 'Ajustes do modo ocupado';

  @override
  String get busyAfterRing => 'Ocupado depois de tocar';

  @override
  String get busyAfterRingHint =>
      'Não Perturbe e respostas automáticas por um tempo, como um treino ou uma soneca.';

  @override
  String get shareCard => 'Compartilhe sua manhã';

  @override
  String get shareCardSubtitle => 'O céu e a frase de hoje, ou sua foto, para Stories e status';

  @override
  String get shareAppMissing => 'Esse app não está neste celular.';

  @override
  String get shareAsIs => 'Compartilhar como está';

  @override
  String get shareTapQuote => 'Toque na frase para trocar.';

  @override
  String get shareStory => 'Story';

  @override
  String get shareSquare => 'Quadrado';

  @override
  String get shareYourWords => 'Suas palavras (opcional)';

  @override
  String get shareYourWordsHint => 'No lugar da frase de hoje';

  @override
  String get shareYourPhoto => 'Sua foto';

  @override
  String get shareOtherPhoto => 'Outra foto';

  @override
  String get shareSkyBack => 'O céu de hoje';

  @override
  String get shareYourVideo => 'Seu vídeo';

  @override
  String get shareInstagramStory => 'Stories do Instagram';

  @override
  String get shareWhatsApp => 'WhatsApp: status ou conversa';

  @override
  String get shareMore => 'Mais apps';

  @override
  String get shareYouPost =>
      'O Quando? abre o app com o seu card pronto. Você escolhe onde vai e toca em Publicar.';

  @override
  String get shareAndroidFirst => 'O compartilhamento chega em breve ao iPhone e iPad.';

  @override
  String songSaved(String name) {
    return '“$name” salvo como som de alarme';
  }

  @override
  String get shareToQuando => 'Compartilhe uma música com o Quando?';

  @override
  String get shareToQuandoHint =>
      'No YouTube, YouTube Music, Spotify, SoundCloud ou Apple Music, toque em Compartilhar e depois em Quando?. Vira um som de alarme que toca no próprio app.';

  @override
  String get askOption => 'Fale ou digite';

  @override
  String get askOptionHint => '“Amanhã às 6”, “30 min antes do nascer do sol”';

  @override
  String get askHint => 'ex.: me acorda 30 min antes do nascer do sol nos dias úteis';

  @override
  String get askListening => 'Ouvindo…';

  @override
  String get askNotUnderstood =>
      'Não encontrei um horário. Tente “7h nos dias úteis” ou “daqui a 20 minutos”.';

  @override
  String askAnswerFromCalendar(String name) {
    return 'Da sua agenda “$name”';
  }

  @override
  String get askAnswerBuiltIn => 'Horários do próprio Quando? para sua cidade';

  @override
  String get askNoAnswer => 'Ainda não achei um horário para isso.';

  @override
  String get askNoSpeech => 'A voz não está disponível neste aparelho. Você pode digitar.';

  @override
  String get askShabbatOff => 'Ative o Shabat nos Ajustes para os horários do Shabat tocarem.';

  @override
  String askSaved(String what) {
    return 'Salvo: $what';
  }

  @override
  String get askMic => 'Falar';

  @override
  String get askMorning => 'Manhã';

  @override
  String get askEvening => 'Noite';

  @override
  String get askUnsure => 'Posso ter perdido parte disso. Confira antes de salvar.';

  @override
  String get askTeach => 'Me ensine isso';

  @override
  String askTaught(String phrase, String time) {
    return 'Entendi: “$phrase” agora quer dizer $time.';
  }

  @override
  String get askSkipAction => 'Pular';

  @override
  String get askNoMatch => 'Nenhum alarme combina com isso.';

  @override
  String askTurnedOff(String what) {
    return 'Desligado: $what';
  }

  @override
  String askSkipped(String what) {
    return 'Pulado: $what';
  }

  @override
  String askEventPlan(String offset, String event) {
    return '$offset “$event” na sua agenda';
  }

  @override
  String askEventNoCalendar(String event) {
    return 'Conecte uma agenda para o Quando? achar “$event”.';
  }

  @override
  String askSnoozeAll(int minutes) {
    return 'Soneca: $minutes min, para este alarme';
  }

  @override
  String askWakeWith(String sound) {
    return 'Te acorda com $sound';
  }

  @override
  String get askReadAs => 'Lido como';

  @override
  String get askHelpTitle => 'Ajude a melhorar os alarmes por voz';

  @override
  String get askHelpBody =>
      'Envia o que você diz ou digita, e o que fez com isso, de forma anônima. Sem conta nem ID do aparelho.';

  @override
  String get askHelpPromptTitle => 'Ajudar o Quando? a entender você?';

  @override
  String askHelpPromptBody(String sentence) {
    return 'Enviaríamos o que você diz ou digita, como “$sentence”, e se você salvou. Anônimo: sem nome, conta nem ID do aparelho. Você pode desligar quando quiser.';
  }

  @override
  String get askHelpYes => 'Sim, ajudar';

  @override
  String get askHelpNo => 'Agora não';
}
