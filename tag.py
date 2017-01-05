import subprocess

SOURCE_VERSION = "2.0"

def main():
	prefix = SOURCE_VERSION + "."
	current = subprocess.check_output("git describe", shell=True)
	last_stable = subprocess.check_output("git tag -l", shell=True).strip().split('\n')[-1]
	if current == last_stable:
		return

	last_stable_split = last_stable.split('.')
	increment = int(last_stable_split[2]) + 1
	incremented = '.'.join(last_stable_split[:2]) + '.' + str(increment)

	replace_in_file('Sources/Info.plist', last_stable, incremented)
	replace_in_file('SmartystreetsSDK.podspec', last_stable, incremented)

	subprocess.check_call('git add Sources/Info.plist SmartystreetsSDK.podspec', shell=True)
	subprocess.check_call('git commit -m "Incremented version number to {0}"'.format(incremented), shell=True)
	subprocess.check_call('git tag -a {0} -m ""'.format(incremented), shell=True)
	subprocess.check_call('git push origin master --tags', shell=True)


def replace_in_file(filename, search, replace):
	with open(filename) as source:
		updated = source.read().replace(search, replace)

	with open(filename, 'w') as update:
		update.write(updated)


if __name__ == '__main__':
	main()
