




#!/usr/bin/env python

import sys, getopt, os, errno, json, subprocess, tempfile

def usage():
    print ("""Usage: %s
    Performs onboarding\offboarding to WDATP locally
""" % sys.argv[0])
    pass

try:
    opts, args = getopt.getopt(sys.argv[1:], 'hc', ['help', 'config='])

    for k, v in opts:
        if k == '-h' or k == '--help':
            usage()
            sys.exit(0)

except getopt.GetoptError as e:
    print (e)
    print ('')
    usage()
    sys.exit(2)

try:
    destfile = '/etc/opt/microsoft/mdatp/mdatp_onboard.json'

    if os.geteuid() != 0:
        print('Re-running as sudo (you may be required to enter sudo''s password)')
        os.execvp('sudo', ['sudo', 'python'] + sys.argv)  # final version

    print('Generating %s ...' % destfile)

    cmd = "sudo mkdir -p '%s'" % (os.path.dirname(destfile))
    subprocess.check_call(cmd, shell = True)

    with open(destfile, "w") as json:
        json.write('''{
  "onboardingInfo": "{\\\"body\\\":\\\"{\\\\\\\"previousOrgIds\\\\\\\":[],\\\\\\\"orgId\\\\\\\":\\\\\\\"5c5b0dba-f7fc-4d2e-8268-5acf869b8f89\\\\\\\",\\\\\\\"geoLocationUrl\\\\\\\":\\\\\\\"https://winatp-gw-neu.microsoft.com/\\\\\\\",\\\\\\\"datacenter\\\\\\\":\\\\\\\"NorthEurope\\\\\\\",\\\\\\\"vortexGeoLocation\\\\\\\":\\\\\\\"EU\\\\\\\",\\\\\\\"version\\\\\\\":\\\\\\\"1.4\\\\\\\",\\\\\\\"deviceType\\\\\\\":\\\\\\\"Server\\\\\\\"}\\\",\\\"sig\\\":\\\"BDM/FlTy3TqYavBwLYxWfKzB1yC8HJlsROmBRsBYz6nON56N7PwPjqE6OqJ6eiYS0DFe1OHgy6xkpnAcT2eF/o7TiyMd6MpG/hpNLIk/JFZr1r/q93iINh8SQuRHhepJttNiVTvIXHBAVUnxClk3WLmelqiEbKZ3VdOd6clrZv8KDYSR7xIOR4S0+OVmUFYsisRuFu+RId7jMcxyrfhr68UIh2Qrtfqtsk7g+gj+vjcbY7vECcv38/3k4k5WaPZpUfyfrlLpkpnylx8RzbicwtupOhm+pm5giqEb/UcKdwKrEptrZOIX0WKN2tXG0pqhPd9xrVrAdNS6E+AnG0Caiw==\\\",\\\"sha256sig\\\":\\\"+odKiwY/NM6JhCbjY7ySE5D8RDU0ti9Jy0kYA7ZCVEO31AvFY88WfVm7TvLJQHhnRlzJc5jbFrcrvysmVKTC+g/a72rzYu+sxzsLZLm00z/DLXy587iwZE0HPOMBcskNOQtHOLYEbEuTmm7l9v8O8r4TrPJFwYzj/EOjjBoY5ihQnG6fnwNJlK4vfkmc/eLvWA8P4C6IowpYRln5jpVw68lwngho6bt6CVYHiBVxu/Xr6UwNghR8xEvFRIK9hSQGpIfedxe/85/UceONqFzCL+jB/dako4w3DjEGDHKIK6TElx21LtgDLJ1nnJjRlKN3/UcBh3rILKK99VZcjknzXA==\\\",\\\"cert\\\":\\\"MIIFgzCCA2ugAwIBAgITMwAAAdt9VVielMaupAAAAAAB2zANBgkqhkiG9w0BAQsFADB+MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYDVQQDEx9NaWNyb3NvZnQgU2VjdXJlIFNlcnZlciBDQSAyMDExMB4XDTIyMDYxNjE4MjMzNloXDTIzMDYxNjE4MjMzNlowHjEcMBoGA1UEAxMTU2V2aWxsZS5XaW5kb3dzLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALqfSbma3gNzT/FeQb0omPgeEgL6ZZDY0PVHl5uAZICrfgW1CdeO0zhqoi+awBNb0iLzhUU1JWUVEQk/zzj9MEGt8USV+VL2jYGsWBpSzxk8HE7huLoJT+OxZ7SZHf16pUJUzYDTWsj6oAdE9Ufqib8e9Jw/mOXh4jAMP+Rfrhxom4/+dwfLuc8fsNHdJwRoiGZyEBlssgQ0O/E0J5+1v/ygqG9baDYMf7tQ6gpJaCqYOXGfjIZjK6k7QSQ/oDYRbqJwIbwh6QhGiEwjybM0PLRAum7ge7n1+AmHgIQtFmxD39NBBGj0wR229e0Cw32cWvCTD79wPo9XrUc14c7SM3kCAwEAAaOCAVgwggFUMA4GA1UdDwEB/wQEAwIFIDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIwDAYDVR0TAQH/BAIwADAeBgNVHREEFzAVghNTZXZpbGxlLldpbmRvd3MuY29tMB0GA1UdDgQWBBT6WeNQNxr8EVKgNNSG95wiH+Mm1TAfBgNVHSMEGDAWgBQ2VollSctbmy88rEIWUE2RuTPXkTBTBgNVHR8ETDBKMEigRqBEhkJodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NybC9NaWNTZWNTZXJDQTIwMTFfMjAxMS0xMC0xOC5jcmwwYAYIKwYBBQUHAQEEVDBSMFAGCCsGAQUFBzAChkRodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NlcnRzL01pY1NlY1NlckNBMjAxMV8yMDExLTEwLTE4LmNydDANBgkqhkiG9w0BAQsFAAOCAgEAoYQOCQkqZzufRA/pGYPupPk9UPEual/TLG7p4/rKZddKfeEImUS72TUA8FFvzro+vI9UE7caEQnj44cEPr4qijE4ppX9BlQKtjhQvvcMBWBTgikDnOgqgwWODhCnXIyJjDYnOSUu5pYTFlGP+ZhlRl9AOuShCZEQQRNJXYzDDA0THdhBpucJHmUe2rV+fTBsTztgXCUfvT7V3MFXkYFGD9YKftTDput2rsmqXKvk34ckEKPTergyGQ1P+oKXDqksRsxDUd9FYsKB06cWNtdHxAw8ZyCXp2ImG7QiEx/jLoYwM72nu4FwLvbmRufGDNGj4xVSBasNkvOgJ2Umt7VFEgheW46dXymAkE549y8qZjHN1GfTqYPsyglsuG3tvYKDgVgCx7evq0iUwfJZAuU/ZI2XWAeTTE167HupzoN68fTJrAFleC1RHFd8EhUS/CMbg0ChssEdpwq0TWwRnsf/5hyVTMIx2YtTkuV0sRL5RrfVYMCxDFbLAelEgZ/83o611Xrud9rGEZeq+3TaTyZiJVYQCvRKQ/jKrz6ihRqcD8rAkXHGejgi/AWS9Br7w6UaGfdnUbWAgnE5U+ueo7YOprBjqSSmvpzmABCHCmIdm+jCK1C4YH4SMfEpdzSj98olWgXqgE0bSaE/RJIxMc49gRtxWmXLalMplWm0xS7G2cE=\\\",\\\"chain\\\":[\\\"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\\\"]}"
}''')

    cmd = "logger -p warning Microsoft ATP: succeeded to save json file %s." % (destfile)
    subprocess.check_call(cmd, shell = True)

except Exception as e:
    print(str(e))
    cmd = "logger -p error Microsoft ATP: failed to save json file %s. Exception occured: %s. " % (destfile, str(e))
    subprocess.call(cmd, shell = True)
    sys.exit(1)