{ ... }:
{
  i18n.defaultLocale = "uz_UZ.UTF-8";
  time.timeZone = "Asia/Tashkent";

  # Select internationalisation properties.
  i18n = {
    extraLocales = [
      "all"
    ];
    supportedLocales = [
      "all"
    ];
  };
}
