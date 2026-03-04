{ ... }:
{
  i18n.defaultLocale = "uz_UZ.UTF-8";
  time.timeZone = "Asia/Tashkent";

  # Select internationalisation properties.
  i18n = {
    extraLocales = [
      "en_US.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
      "uz_UZ.UTF-8/UTF-8"
    ];
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
      "uz_UZ.UTF-8/UTF-8"
    ];
  };
}
