//inspired from: https://medium.com/swlh/how-to-create-a-self-updating-readme-md-for-your-github-profile-f8b05744ca91

const fs = require('fs');
const Mustache = require('mustache');

const versionsToApply = JSON.parse(fs.readFileSync('./versions.json', 'utf8'))

const generateReadMe = () => {
    fs.readFile('./readme.mustache', (err, readme) => {
        if (err) throw err;

        let templateData = [];
        Object.entries(versionsToApply).map(([name, version]) => {
            templateData.push({name, version})
        })

        fs.writeFileSync(
            'generated/README.md',
            Mustache.render(readme.toString(), {tools: templateData})
        );
    });
}

const generateCurrentVersions = () => {
    fs.writeFileSync(
        'generated/current-versions.json',
        JSON.stringify(versionsToApply)
    );
}

generateReadMe()
generateCurrentVersions()
