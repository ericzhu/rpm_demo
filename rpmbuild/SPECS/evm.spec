Name:           tuprepo
Version:        1.0
Release:        0
Summary:        network repo for TUP CentOS Servers

License:        GPL
URL:            http://locahost
Source0:        evm.tar.gz
BuildArch:      noarch
BuildRoot:      %{_tmppath}/%{name}-buildroot

%description
Create a YUM repo file in the /etc/yum.repos.d/ folder

%prep
%setup -q

%install
mkdir -p "$RPM_BUILD_ROOT"
cp -R * "$RPM_BUILD_ROOT"

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-, root, root, -)
/etc/yum.repos.d/CentOS-Tup.repo
